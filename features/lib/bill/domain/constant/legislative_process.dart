enum LegislativeProcess {

  propose("발의", 1),
  reportToPlenarySession("본회의 보고", 2),
  referralToCommittee("소관위원회 회부", 3),
  priorAnnouncementOfLegislation("입법예고", 4),
  committeeReview("위원회 심사", 5),
  judiciaryCommitteeReview("법사위 체계자구 심사", 6),
  submissionOfReportOnExamination("심사보고서 제출", 7),
  plenarySessionDeliberation("본회의 심의", 8),
  transferToGovernment("정부 이송", 9),
  promulgation("공포", 10)
  ;

  final String name;
  final int order;

  const LegislativeProcess(this.name, this.order);
}