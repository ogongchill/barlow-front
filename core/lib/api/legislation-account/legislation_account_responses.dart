import 'dart:convert';
// import 'package:front/core/api/common/common_responses.dart';
import 'package:core/api/common/common_responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legislation_account_responses.g.dart';

@JsonSerializable()
class LegislationAccountBillPostThumbnailsResponseBody {

  final List<BillPostThumbnail> today;
  final List<BillPostThumbnail> recent;
  final bool isLastPage;

  LegislationAccountBillPostThumbnailsResponseBody({
    required this.today,
    required this.recent,
    required this.isLastPage
  });

  factory LegislationAccountBillPostThumbnailsResponseBody.fromJson(Map<String, dynamic> json) => _$LegislationAccountBillPostThumbnailsResponseBodyFromJson(json);

  String toJsonString() => jsonEncode(_$LegislationAccountBillPostThumbnailsResponseBodyToJson(this));
}

@JsonSerializable()
class LegislationAccountBillPostDetailResponseBody {

  final String title;
  final String proposerSummary;
  final String proposerType;
  final String legislativeBody;
  final DateTime createdAt;
  final String detail;
  final SummarySection? summarySection;
  final ProposerSection? proposerSection;

  LegislationAccountBillPostDetailResponseBody({
    required this.title,
    required this.proposerSummary,
    required this.proposerType,
    required this.legislativeBody,
    required this.createdAt,
    required this.detail,
    required this.summarySection,
    required this.proposerSection
  });

  factory LegislationAccountBillPostDetailResponseBody.fromJson(Map<String, dynamic> json) => _$LegislationAccountBillPostDetailResponseBodyFromJson(json);
}

@JsonSerializable()
class LegislationAccountProfileResponseBody {

  final String accountName;
  final String iconUrl;
  final String description;
  final int postCount;
  final int subscriberCount;
  final bool isSubscribe;
  final bool isNotifiable;

  LegislationAccountProfileResponseBody({
    required this.accountName,
    required this.iconUrl,
    required this.description,
    required this.postCount,
    required this.subscriberCount,
    required this.isSubscribe,
    required this.isNotifiable
  });

  factory LegislationAccountProfileResponseBody.fromJson(Map<String, dynamic> json) => _$LegislationAccountProfileResponseBodyFromJson(json);
}

@JsonSerializable()
class CommitteeAccountResponseBody {

  final String title;
  final String subtitle;
  final String description;
  final List<CommitteeAccount> accounts;

  CommitteeAccountResponseBody({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accounts
  });

  factory CommitteeAccountResponseBody.fromJson(Map<String, dynamic> json) => _$CommitteeAccountResponseBodyFromJson(json);
}

@JsonSerializable()
class CommitteeAccount {

  final int accountNo;
  final String accountName;
  final String iconUrl;
  final bool isSubscribed;
  final bool isNotifiable;

  CommitteeAccount({
    required this.accountNo,
    required this.accountName,
    required this.iconUrl,
    required this.isSubscribed,
    required this.isNotifiable
  });

  factory CommitteeAccount.fromJson(Map<String, dynamic> json) => _$CommitteeAccountFromJson(json);
}
