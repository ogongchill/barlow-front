import 'dart:convert';

import 'package:front/core/api/common/api_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_requests.g.dart';

enum DeviceOs {

  @JsonValue('ios')
  ios,

  @JsonValue('android')
  android,
  ;
}

class SignupRequest extends BodyRequest {
  SignupRequest(SignupRequestBody body)
  : super(body.toJson());
}

@JsonSerializable()
class SignupRequestBody {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;
  final String nickName;

  SignupRequestBody({required this.deviceOs, required this.deviceId, required this.deviceToken, required this.nickName});

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
  String toJsonString() =>  jsonEncode(_$SignupRequestToJson(this));
}

class LoginRequest extends BodyRequest {
  LoginRequest(LoginRequestBody body)
      : super(body.toJson());
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

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
  String toJsonString() => jsonEncode(_$LoginRequestToJson(this));
}
