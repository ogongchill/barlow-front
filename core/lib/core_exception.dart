enum ExceptionType{
  internal,
  external
}

class CoreException implements Exception {

  final ExceptionType type;
  final String message;

  CoreException(this.type, this.message);

  @override
  String toString() => 'CoreException[$type]{message: $message)}';
}