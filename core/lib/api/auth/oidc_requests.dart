import 'package:json_annotation/json_annotation.dart';
import 'package:core/api/auth/auth_requests.dart';

part 'oidc_requests.g.dart';

@JsonSerializable(createFactory: false)
class OidcSignupRequest {

  final OidcPayload oidcPayload;
  final TermAgreements termAgreement;
  final SignupRequestBody signupPayload;

  OidcSignupRequest({
      required this.oidcPayload,
      required this.termAgreement,
      required this.signupPayload
  });

  Map<String, dynamic> toJson() => _$OidcSignupRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class OidcLoginRequest {

  final DeviceOs deviceOs;
  final String deviceId;
  final String deviceToken;
  final OidcPayload oidcPayload;

  OidcLoginRequest({
    required this.deviceOs,
    required this.deviceId,
    required this.deviceToken,
    required this.oidcPayload
  });

  Map<String, dynamic> toJson() => _$OidcLoginRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class TermAgreements {

  final Map<int, bool> termAgreements;

  TermAgreements({required this.termAgreements});

  Map<String, dynamic> toJson() => _$TermAgreementsToJson(this);
}

@JsonSerializable(createFactory: false)
class OidcPayload {

  final String authProvider;
  final String idToken;

  OidcPayload({
    required this.authProvider,
    required this.idToken
  });

  Map<String, dynamic> toJson() => _$OidcPayloadToJson(this);
}