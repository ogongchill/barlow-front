enum ProgressStatus {

  received("접수", "RECEIVED"),
  committeeReceived("소관위접수", "COMMITTEE_RECEIVED"),
  committeeReview("소관위심사", "COMMITTEE_REVIEW"),
  replacedAndDiscarded("대안반영폐기", "REPLACED_AND_DISCARDED"),
  systematicWordingReview("체계자구심사", "SYSTEMATIC_WORDING_REVIEW"),
  plenarySubmitted("본회의부의안건", "PLENARY_SUBMITTED"),
  plenaryDecided("본회의의결", "PLENARY_DECIDED"),
  withdrawn("철회", "WITHDRAWN"),
  governmentTransferred("정부이송", "GOVERNMENT_TRANSFERRED"),
  redemandRequested("재의요구", "REDEMAND_REQUESTED"),
  rejected("재의(부결)", "REJECTED"),
  promulgated("공포", "PROMULGATED"),
  abrogate("폐기", "ABROGATE");

  final String _value;
  final String _upperCaseWithUnderscore;

  const ProgressStatus(this._value, this._upperCaseWithUnderscore);

  static ProgressStatus findByValue(String value) {
    return ProgressStatus.values.firstWhere(
          (progress) => progress._value == value,
      orElse: () => throw ArgumentError('$value 에 대한 ProgressStatus 은 존재하지 않습니다'),
    );
  }

  String get value => _value;
  String get upperCaseWithUnderscore => _upperCaseWithUnderscore;
}
