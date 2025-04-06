class SortKey {

  static SortKey asc = SortKey._(true);
  static SortKey dsc = SortKey._(false);

  final bool _isAscending;

  SortKey._(this._isAscending);

  bool get isAscending => _isAscending;
  bool get isDescending => !_isAscending;
}