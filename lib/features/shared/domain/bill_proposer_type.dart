enum BillProposerType {

  government("정부", "GOVERNMENT"),
  chairman("위원장", "CHAIRMAN"),
  speaker("의장", "SPEAKER"),
  lawmaker("의원", "LAWMAKER"),

  etc("기타", "ETC")
  ;

  final String _value;
  final String _upperCaseWithUnderscore;

  const BillProposerType(this._value, this._upperCaseWithUnderscore);

  String get value => _value;
  String get upperCaseWithUnderscore => _upperCaseWithUnderscore;
}