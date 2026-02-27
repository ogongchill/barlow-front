import 'package:core/api/api_exception.dart';
import 'package:core/api/error_handler_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

/// ErrorHandlerInterceptor의 에러 파싱 로직을 검증한다.
///
/// 실제 Dio 요청 없이 [DioException]을 직접 생성하여
/// [ErrorHandlerInterceptor.onError] 동작을 확인한다.
void main() {
  late ErrorHandlerInterceptor interceptor;

  setUp(() {
    interceptor = ErrorHandlerInterceptor();
  });

  group('ErrorHandlerInterceptor', () {
    group('표준 에러 포맷 파싱', () {
      test('result=ERROR, error 필드 존재 시 error.code와 error.message를 추출한다', () {
        final responseData = {
          'result': 'ERROR',
          'data': null,
          'error': {
            'code': 'E409',
            'message': '이미 다른 계정에 등록되어있습니다.',
            'data': null,
          },
        };

        DioException? captured;
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 409,
            data: responseData,
          ),
          type: DioExceptionType.badResponse,
        );

        final handler = _CapturingErrorInterceptorHandler(
          onReject: (e) => captured = e,
        );
        interceptor.onError(dioException, handler);

        expect(captured, isNotNull);
        final apiException = captured!.error as ApiException;
        expect(apiException.code, equals('E409'));
        expect(apiException.message, equals('이미 다른 계정에 등록되어있습니다.'));
      });

      test('result=SUCCESS이면 표준 에러 분기 미진입으로 statusCode를 code로 사용한다', () {
        final responseData = {
          'result': 'SUCCESS',
          'data': null,
          'error': null,
        };

        DioException? captured;
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 200,
            data: responseData,
          ),
          type: DioExceptionType.badResponse,
        );

        final handler = _CapturingErrorInterceptorHandler(
          onReject: (e) => captured = e,
        );
        interceptor.onError(dioException, handler);

        expect(captured, isNotNull);
        final apiException = captured!.error as ApiException;
        expect(apiException.code, equals('200'));
      });
    });

    group('비표준 에러 포맷 fallback', () {
      test('응답 data가 null이면 statusCode를 code, err.message를 message로 사용한다', () {
        DioException? captured;
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 500,
            data: null,
          ),
          type: DioExceptionType.badResponse,
          message: 'Internal Server Error',
        );

        final handler = _CapturingErrorInterceptorHandler(
          onReject: (e) => captured = e,
        );
        interceptor.onError(dioException, handler);

        expect(captured, isNotNull);
        final apiException = captured!.error as ApiException;
        expect(apiException.code, equals('500'));
        expect(apiException.message, equals('Internal Server Error'));
      });

      test('응답 자체가 null이면 code=unknown, message=알 수 없는 오류가 발생했습니다.', () {
        DioException? captured;
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.connectionTimeout,
        );

        final handler = _CapturingErrorInterceptorHandler(
          onReject: (e) => captured = e,
        );
        interceptor.onError(dioException, handler);

        expect(captured, isNotNull);
        final apiException = captured!.error as ApiException;
        expect(apiException.code, equals('unknown'));
        expect(apiException.message, equals('알 수 없는 오류가 발생했습니다.'));
      });

      test('응답 data가 JSON 파싱 불가능한 문자열이면 raw string을 message로 사용한다', () {
        DioException? captured;
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 502,
            data: 'Bad Gateway',
          ),
          type: DioExceptionType.badResponse,
        );

        final handler = _CapturingErrorInterceptorHandler(
          onReject: (e) => captured = e,
        );
        interceptor.onError(dioException, handler);

        expect(captured, isNotNull);
        final apiException = captured!.error as ApiException;
        expect(apiException.code, equals('502'));
        expect(apiException.message, equals('Bad Gateway'));
      });
    });

    group('reject DioException 래핑', () {
      test('reject된 DioException의 error 필드에 ApiException이 담기고 message가 동기화된다', () {
        final responseData = {
          'result': 'ERROR',
          'data': null,
          'error': {
            'code': 'E401',
            'message': '인증이 필요합니다.',
            'data': null,
          },
        };

        DioException? captured;
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 401,
            data: responseData,
          ),
          type: DioExceptionType.badResponse,
        );

        final handler = _CapturingErrorInterceptorHandler(
          onReject: (e) => captured = e,
        );
        interceptor.onError(dioException, handler);

        expect(captured!.error, isA<ApiException>());
        expect(captured!.message, equals('인증이 필요합니다.'));
      });
    });
  });
}

/// [ErrorInterceptorHandler]의 reject 호출을 캡처하는 테스트 헬퍼.
class _CapturingErrorInterceptorHandler extends ErrorInterceptorHandler {
  final void Function(DioException) onReject;

  _CapturingErrorInterceptorHandler({required this.onReject});

  @override
  void reject(DioException err) {
    onReject(err);
  }
}
