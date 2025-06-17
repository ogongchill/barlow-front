import 'package:core/api/common/common_responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recent_bill_responses.g.dart';

@JsonSerializable()
class RecentBillThumbnailResponseBody {

  final List<BillPostThumbnail> today;
  final List<BillPostThumbnail> recent;

  RecentBillThumbnailResponseBody({
    required this.today,
    required this.recent
  });

  factory RecentBillThumbnailResponseBody.fromJson(Map<String, dynamic> json) => _$RecentBillThumbnailResponseBodyFromJson(json);
}

@JsonSerializable()
class RecentBillDetailResponseBody {

  final String title;
  final String proposerSummary;
  final String proposerType;
  final String legislativeBody;
  final DateTime createdAt;
  final String? detail;
  final SummarySection summarySection;
  final ProposerSection? proposerSection;

  RecentBillDetailResponseBody({
    required this.title,
    required this.proposerSummary,
    required this.proposerType,
    required this.legislativeBody,
    required this.createdAt,
    required this.detail,
    required this.summarySection,
    required this.proposerSection
  });

  factory RecentBillDetailResponseBody.fromJson(Map<String, dynamic> json) => _$RecentBillDetailResponseBodyFromJson(json);
}