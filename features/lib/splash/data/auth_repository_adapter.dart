import 'package:core/api/api_router.dart';
import 'package:core/api/auth/auth_requests.dart';
import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:features/splash/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryAdapter implements AuthRepository {

  final ApiRouter _router;
  final DeviceInfo _deviceInfo;
  final FcmManager _firebaseManager;

  AuthRepositoryAdapter({
    required ApiRouter router,
    required DeviceInfo deviceInfo,
    required FcmManager firebaseManager
  }): _router = router,
      _deviceInfo = deviceInfo,
      _firebaseManager = firebaseManager;

  @override
  Future<String> guestLogin() async {
    String? fcmToken = await getFcmToken();
    final response = await _router.authRouter.guestLogin(
        LoginRequestBody(
            deviceOs: DeviceOs.fromString(_deviceInfo.deviceOs),
            deviceId: _deviceInfo.deviceId,
            deviceToken: fcmToken!
        )
    );
    return response!.accessToken;
  }

  @override
  Future<String> guestSingUp(String id, String nickname) async {
    String? fcmToken = await getFcmToken();
    final response = await _router.authRouter.guestSingUp(
      SignupRequestBody(
          deviceOs: DeviceOs.fromString(_deviceInfo.deviceOs),
          deviceId: id,
          deviceToken: fcmToken!,
          nickname: nickname
      )
    );
    return response!.accessToken;
  }

  Future<String?> getFcmToken() async {
    return _firebaseManager.getToken();
  }
}