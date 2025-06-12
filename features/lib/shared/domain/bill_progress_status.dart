import 'package:core/api/constants/progress_status_param.dart';

enum ProgressStatus {

  received("접수", ProgressStatusParam.received),
  committeeReceived("소관위접수", ProgressStatusParam.received),
  committeeReview("소관위심사", ProgressStatusParam.committeeReview),
  replacedAndDiscarded("대안반영폐기", ProgressStatusParam.replacedAndDiscarded),
  systematicWordingReview("체계자구심사", ProgressStatusParam.systematicWordingReview),
  plenarySubmitted("본회의부의안건", ProgressStatusParam.plenarySubmitted),
  plenaryDecided("본회의의결", ProgressStatusParam.plenaryDecided),
  withdrawn("철회", ProgressStatusParam.withdrawn),
  governmentTransferred("정부이송", ProgressStatusParam.governmentTransferred),
  redemandRequested("재의요구", ProgressStatusParam.redemandRequested),
  rejected("재의(부결)", ProgressStatusParam.rejected),
  promulgated("공포", ProgressStatusParam.promulgated),
  abrogate("폐기", ProgressStatusParam.abrogate);

  final String value;
  final ProgressStatusParam param;

  const ProgressStatus(this.value, this.param);

  static ProgressStatus findByValue(String target) {
    return ProgressStatus.values.firstWhere(
          (progress) => progress.value == target,
      orElse: () => throw StateError('$target 에 대한 ProgressStatus 은 존재하지 않습니다'),
    );
  }
}
