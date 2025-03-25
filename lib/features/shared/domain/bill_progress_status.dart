enum ProgressStatus {

  received("접수"),
  committeeReceived("소관위접수"),
  committeeReview("소관위심사"),
  replacedAndDiscarded("대안반영폐기"),
  systematicWordingReview("체계자구심사"),
  plenarySubmitted("본회의부의안건"),
  plenaryDecided("본회의의결"), // 이거랑
  withdrawn("철회"), // 이거랑
  governmentTransferred("정부이송"), // 이거랑
  redemandRequested("재의요구"), // 이거랑
  rejected("재의(부결)"),
  promulgated("공포"); // 이거랑

  final String _value;

  const ProgressStatus(this._value);

  static ProgressStatus findByValue(String value) {
    return ProgressStatus.values.firstWhere(
          (progress) => progress._value == value,
      orElse: () => throw ArgumentError('$value 에 대한 ProgressStatus 은 존재하지 않습니다'),
    );
  }

  String get value => _value;
}
