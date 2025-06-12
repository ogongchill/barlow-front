enum BillProposerParam {

  government("GOVERNMENT"), // 정부
  chairman("CHAIRMAN"), // 위원장
  speaker("SPEAKER"), // 의장
  lawmaker("LAWMAKER"), // 의원

  etc("ETC") // 기타
  ;

  final String value;

  const BillProposerParam(this.value);
}