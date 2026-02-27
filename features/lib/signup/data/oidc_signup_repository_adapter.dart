import 'package:core/api/api_router.dart';
import 'package:core/api/auth/auth_requests.dart';
import 'package:core/api/auth/oidc_requests.dart';
import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/oidc_signup_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: OidcSignupRepository)
class OidcSignupRepositoryAdapter implements OidcSignupRepository {

  final ApiRouter _router;
  final DeviceInfo _deviceInfo;
  final FcmManager _fcmManager;

  OidcSignupRepositoryAdapter({
    required ApiRouter router,
    required DeviceInfo deviceInfo,
    required FcmManager fcmManager,
  })  : _router = router,
        _deviceInfo = deviceInfo,
        _fcmManager = fcmManager;

  @override
  Future<String> signUp(OidcSignupInfo info) async {
    final fcmToken = await _fcmManager.getToken();
    final request = OidcSignupRequest(
      oidcPayload: OidcPayload(
        authProvider: info.provider.apiValue,
        idToken: info.idToken,
      ),
      termAgreement: TermAgreements(
        termAgreements: {
          for (final item in info.termAgreements) item.id: item.isAgreed,
        },
      ),
      signupPayload: SignupRequestBody(
        deviceOs: DeviceOs.fromString(_deviceInfo.deviceOs),
        deviceId: Uuid().v4(),
        deviceToken: fcmToken!,
        nickname: info.nickname,
      ),
    );
    final response = await _router.authRouter.oidcSignUp(request);
    return response!.accessToken;
  }
}
