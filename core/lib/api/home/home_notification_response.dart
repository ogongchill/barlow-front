import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'home_notification_response.g.dart';

@JsonSerializable()
class HomeNotificationCenterResponse {

  final List<HomeNotificationCenterResponseItem> items;

  HomeNotificationCenterResponse({
    required this.items
  });

  factory HomeNotificationCenterResponse.fromJson(Map<String, dynamic> json) => _$HomeNotificationCenterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeNotificationCenterResponseToJson(this);
  String toJsonString() => jsonEncode(toJson());
}

@JsonSerializable()
class HomeNotificationCenterResponseItem {

  final String topic;
  final String title;
  final String body;
  final String iconUrl;
  final String billId;
  final DateTime createdAt;

  HomeNotificationCenterResponseItem({
    required this.topic,
    required this.title,
    required this.body,
    required this.iconUrl,
    required this.billId,
    required this.createdAt
  });

  factory HomeNotificationCenterResponseItem.fromJson(Map<String, dynamic> json) => _$HomeNotificationCenterResponseItemFromJson(json);
  Map<String, dynamic> toJson() => _$HomeNotificationCenterResponseItemToJson(this);
}