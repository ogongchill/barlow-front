enum BillProposerType {

  government("정부"),
  chairman("위원장"),
  speaker("의장"),
  lawmaker("의원"),

  etc("기타")
  ;

  final String _value;

  const BillProposerType(this._value);

  String get value => _value;
}