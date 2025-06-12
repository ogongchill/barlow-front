import 'package:json_annotation/json_annotation.dart';

part 'menu_responses.g.dart';

@JsonSerializable()
class NotificationMenuResponseBody {

  final String title;
  final List<NotificationMenuSetting> settings;

  NotificationMenuResponseBody({
    required this.title,
    required this.settings
  });

  factory NotificationMenuResponseBody.fromJson(Map<String, dynamic> json) => _$NotificationMenuResponseBodyFromJson(json);
}

@JsonSerializable()
class NotificationMenuSetting {

  final String name;
  final String iconPath;
  final bool isEnable;

  NotificationMenuSetting({
    required this.name,
    required this.iconPath,
    required this.isEnable
  });

  factory NotificationMenuSetting.fromJson(Map<String, dynamic> json) => _$NotificationMenuSettingFromJson(json);
}