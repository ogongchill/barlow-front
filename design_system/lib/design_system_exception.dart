enum DesignSystemExceptionType {

  usageError,
  internalError
}

class DesignSystemException implements Exception {

  final DesignSystemExceptionType type;
  final String message;

  const DesignSystemException._(this.type, this.message);

  factory DesignSystemException.usage(String message) =>
      DesignSystemException._(DesignSystemExceptionType.usageError, message);

  factory DesignSystemException.internal(String message) =>
      DesignSystemException._(DesignSystemExceptionType.internalError, message);

  @override
  String toString() => 'DesignSystemException [$type]: $message';
}