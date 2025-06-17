import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'auth_requests.g.dart';

enum DeviceOs {

  @JsonValue('ios')
  ios,

  @JsonValue('android')
  android,
  ;

  static DeviceOs fromString(String value) {
    if(value == "ios") {
      return DeviceOs.ios;
    }
    if(value == "android") {
      return DeviceOs.android;
    }
    throw UnimplementedError("ios, android 가 아닌 deviceOs 식별 불가능");
  }
}

@JsonSerializable()
class SignupRequestBody {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;
  final String nickname;

  SignupRequestBody({required this.deviceOs, required this.deviceId, required this.deviceToken, required this.nickname});

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
  String toJsonString() =>  jsonEncode(_$SignupRequestBodyToJson(this));
}

@JsonSerializable()
class LoginRequestBody {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;

  LoginRequestBody({
    required this.deviceOs,
    required this.deviceId,
    required this.deviceToken
  });

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
  String toJsonString() => jsonEncode(_$LoginRequestBodyToJson(this));
}
