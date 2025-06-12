
import 'package:core/api/constants/committee_param.dart';

sealed class LegislationType {

  static const parameterName = "legislationType";
  final String value;

  LegislationType._(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LegislationType &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class CommitteeLegislationType extends LegislationType {

  final CommitteeParam committeeType;

  CommitteeLegislationType.of(this.committeeType) : super._(committeeType.value);
}

class OtherLegislationType extends LegislationType {

  static final government = OtherLegislationType._("GOVERNMENT");
  static final speaker = OtherLegislationType._("SPEAKER");
  static final empty = OtherLegislationType._("EMPTY");
  static final specialCommittee = OtherLegislationType._("SPECIAL_COMMITTEE");

  OtherLegislationType._(super.value): super._();
}