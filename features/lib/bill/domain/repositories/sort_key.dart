class PreAnnounceBillPostSortKey {

  static PreAnnounceBillPostSortKey asc = PreAnnounceBillPostSortKey._(true);
  static PreAnnounceBillPostSortKey dsc = PreAnnounceBillPostSortKey._(false);

  final bool _isAscending;

  PreAnnounceBillPostSortKey._(this._isAscending);

  bool get isAscending => _isAscending;
  bool get isDescending => !_isAscending;
}