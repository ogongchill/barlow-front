import 'package:core/core_exception.dart';

class ApiException extends CoreException {

  final String code;

  ApiException({required this.code, required String message})
  :super(ExceptionType.external, message);

  @override
  String toString() {
    return 'ApiException{code: $code, message: $message}';
  }
}