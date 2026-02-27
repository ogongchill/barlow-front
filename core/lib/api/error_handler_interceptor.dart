import 'dart:convert';

import 'package:core/api/api_exception.dart';
import 'package:core/api/common/api_response.dart';
import 'package:dio/dio.dart';

/// DioException 발생 시 응답 body를 파싱하여 [ApiException]으로 변환한다.
///
/// 파싱 규칙:
/// - 응답 body가 표준 에러 포맷(`result: ERROR, error: {...}`)이면
///   `error.code` / `error.message`를 추출한다.
/// - 표준 포맷이 아니거나 파싱 실패 시 raw response data를 message로 사용한다.
class ErrorHandlerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiException = _parseApiException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: apiException,
        message: apiException.message,
      ),
    );
  }

  ApiException _parseApiException(DioException err) {
    final responseData = err.response?.data;

    if (responseData != null) {
      try {
        final Map<String, dynamic> json = responseData is Map<String, dynamic>
            ? responseData
            : jsonDecode(responseData as String) as Map<String, dynamic>;

        final apiResponse = ApiResponse.fromJson(json, (data) => data);
        if (apiResponse.result == ResultType.error && apiResponse.error != null) {
          final error = apiResponse.error!;
          return ApiException(code: error.code, message: error.message);
        }
      } catch (_) {
        // 파싱 실패 시 fallthrough
      }
    }

    // 표준 포맷이 아닌 경우: raw data를 message로 사용
    final rawMessage = responseData?.toString()
        ?? err.message
        ?? '알 수 없는 오류가 발생했습니다.';
    final statusCode = err.response?.statusCode?.toString() ?? 'unknown';
    return ApiException(code: statusCode, message: rawMessage);
  }
}
