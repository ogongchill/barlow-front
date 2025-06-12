import 'package:core/api/api_router.dart';
import 'package:core/api/auth/auth_requests.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:features/splash/domain/repositories/auth_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepositoryAdapter implements AuthRepository {

  final ApiRouter _router;
  final DeviceInfo _deviceInfo;
  final FirebaseMessaging _firebaseMessaging;

  AuthRepositoryAdapter({
    required ApiRouter router,
    required DeviceInfo deviceInfo,
    required FirebaseMessaging firebaseMessaging
  }): _router = router,
      _deviceInfo = deviceInfo,
      _firebaseMessaging = firebaseMessaging;

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
    String? fcmToken = await _firebaseMessaging.getToken();
    if(fcmToken == null) {
      throw StateError("fcm token이 초기화 되지 않음");
    }
    return fcmToken;
  }
}