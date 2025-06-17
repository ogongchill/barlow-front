enum ErrorImage {

  somethingWentWrong('packages/design_system/assets/error/error_picture.png'),
  ;

  final String _path;

  const ErrorImage(this._path);

  String get path => _path;
}