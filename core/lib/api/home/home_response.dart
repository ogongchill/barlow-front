import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {

  final bool isNotificationArrived;
  final SubscribeSection subscribeSection;
  final TodayBillPostSection todayBillPostSection;

  HomeResponse({
    required this.isNotificationArrived,
    required this.subscribeSection,
    required this.todayBillPostSection
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);
  String toJsonString() => jsonEncode(_$HomeResponseToJson(this));
}

@JsonSerializable()
class TodayBillPostSection {

  final String? display;
  final List<BillPostThumbnail> postThumbnails;

  TodayBillPostSection({
    required this.display,
    required this.postThumbnails
  });

  factory TodayBillPostSection.fromJson(Map<String, dynamic> json) => _$TodayBillPostSectionFromJson(json);
  Map<String, dynamic> toJson() => _$TodayBillPostSectionToJson(this);
}

@JsonSerializable()
class BillPostThumbnail {

  final String billId;
  final String billName;
  final String proposers;
  final DateTime createdAt;

  BillPostThumbnail({
    required this.billId,
    required this.billName,
    required this.proposers,
    required this.createdAt
  });

  factory BillPostThumbnail.fromJson(Map<String, dynamic> json) => _$BillPostThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$BillPostThumbnailToJson(this);
}

@JsonSerializable()
class SubscribeSection {

  final String? display;
  final List<SubscribeLegislationBody> subscribeLegislationBodies;

  SubscribeSection({
    required this.display,
    required this.subscribeLegislationBodies
  });

  factory SubscribeSection.fromJson(Map<String, dynamic> json) => _$SubscribeSectionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeSectionToJson(this);
}

@JsonSerializable()
class SubscribeLegislationBody {

  final int no;
  final String bodyType;
  final String iconImageUrl;

  SubscribeLegislationBody({
    required this.no,
    required this.bodyType,
    required this.iconImageUrl
  });

  factory SubscribeLegislationBody.fromJson(Map<String, dynamic> json) => _$SubscribeLegislationBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeLegislationBodyToJson(this);
}