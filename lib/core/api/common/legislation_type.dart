import 'package:front/features/shared/domain/committee.dart';

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

  final Committee committee;

  CommitteeLegislationType.of(this.committee) : super._(committee.camelToUpperUnderscore());
}

class OtherLegislationType extends LegislationType {

  static final government = OtherLegislationType._("GOVERNMENT");
  static final speaker = OtherLegislationType._("SPEAKER");
  static final empty = OtherLegislationType._("EMPTY");
  static final specialCommittee = OtherLegislationType._("SPECIAL_COMMITTEE");

  OtherLegislationType._(super.value): super._();
}


