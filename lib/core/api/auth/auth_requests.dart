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
class SignupRequestBody {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;
  final String nickName;

  SignupRequestBody({required this.deviceOs, required this.deviceId, required this.deviceToken, required this.nickName});

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
