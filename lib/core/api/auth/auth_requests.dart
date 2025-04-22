import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'auth_requests.g.dart';

enum DeviceOs {

  @JsonValue('ios')
  ios,

  @JsonValue('android')
  android,
  ;
}

@JsonSerializable()
class SignupRequest {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;
  final String nickName;

  SignupRequest({required this.deviceOs, required this.deviceId, required this.deviceToken, required this.nickName});

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
  String toJsonString() =>  jsonEncode(_$SignupRequestToJson(this));
}

@JsonSerializable()
class LoginRequest {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;

  LoginRequest({
    required this.deviceOs,
    required this.deviceId,
    required this.deviceToken
  });

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
  String toJsonString() => jsonEncode(_$LoginRequestToJson(this));
}
