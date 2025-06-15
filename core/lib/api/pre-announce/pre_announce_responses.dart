import 'package:core/api/common/common_responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pre_announce_responses.g.dart';

@JsonSerializable()
class PreAnnounceBillPostsResponseBody {

  final String display;
  final List<JsonPreAnnounceBillThumbnail> thumbnails;
  final bool isLastPage;

  PreAnnounceBillPostsResponseBody({
    required this.display,
    required this.thumbnails,
    required this.isLastPage
  });

  factory PreAnnounceBillPostsResponseBody.fromJson(Map<String, dynamic> json) => _$PreAnnounceBillPostsResponseBodyFromJson(json);
}

@JsonSerializable()
class JsonPreAnnounceBillThumbnail{

  final String billId;
  final String billName;
  final String proposers;
  final String legislativeBody;
  final int dDay;

  JsonPreAnnounceBillThumbnail({
    required this.billId,
    required this.billName,
    required this.proposers,
    required this.legislativeBody,
    required this.dDay
  });

  factory JsonPreAnnounceBillThumbnail.fromJson(Map<String, dynamic> json) => _$JsonPreAnnounceBillThumbnailFromJson(json);
}

@JsonSerializable()
class PreAnnounceBillPostsDetailResponseBody {

  final String title;
  final String proposerSummary;
  final String legislativeBody;
  final String detail;
  final PreAnnouncementSection preAnnouncementSection;
  final SummarySection summarySection;
  final ProposerSection? proposerSection;

  PreAnnounceBillPostsDetailResponseBody({
    required this.title,
    required this.proposerSummary,
    required this.legislativeBody,
    required this.detail,
    required this.preAnnouncementSection,
    required this.summarySection,
    required this.proposerSection
  });

  factory PreAnnounceBillPostsDetailResponseBody.fromJson(Map<String, dynamic> json) => _$PreAnnounceBillPostsDetailResponseBodyFromJson(json);
}

@JsonSerializable()
class PreAnnouncementSection {

  final DateTime deadline;
  final String linkUrl;
  final int dDay;

  PreAnnouncementSection({
    required this.deadline,
    required this.linkUrl,
    required this.dDay
  });

  factory PreAnnouncementSection.fromJson(Map<String, dynamic> json) => _$PreAnnouncementSectionFromJson(json);
}