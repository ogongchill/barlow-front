enum ProgressStatusParam {

  received("RECEIVED"), // 접수
  committeeReceived("COMMITTEE_RECEIVED"), // 소관위접수
  committeeReview("COMMITTEE_REVIEW"), // 소관위 심사
  replacedAndDiscarded("REPLACED_AND_DISCARDED"), // 대안 반영 폐기
  systematicWordingReview("SYSTEMATIC_WORDING_REVIEW"), // 체계자구심사
  plenarySubmitted("PLENARY_SUBMITTED"),// 본회의부의안건
  plenaryDecided("PLENARY_DECIDED"), // 본회의의결
  withdrawn("WITHDRAWN"), // 철회
  governmentTransferred("GOVERNMENT_TRANSFERRED"), // 정부이송
  redemandRequested("REDEMAND_REQUESTED"), // 재의요구
  rejected("REJECTED"), // 재의(부결)
  promulgated("PROMULGATED"), // 공포
  abrogate("ABROGATE"), // 폐기
  ;

  final String value;

  const ProgressStatusParam(this.value);
}
