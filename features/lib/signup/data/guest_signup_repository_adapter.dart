import 'package:core/api/api_router.dart';
import 'package:core/api/auth/auth_requests.dart';
import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:features/signup/domain/entities/guest_signup_info.dart';
import 'package:features/signup/domain/repositories/guest_signup_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: GuestSignupRepository)
class GuestSignupRepositoryAdapter implements GuestSignupRepository {
  final ApiRouter _router;
  final DeviceInfo _deviceInfo;
  final FcmManager _fcmManager;

  GuestSignupRepositoryAdapter({
    required ApiRouter router,
    required DeviceInfo deviceInfo,
    required FcmManager fcmManager,
  })  : _router = router,
        _deviceInfo = deviceInfo,
        _fcmManager = fcmManager;

  @override
  Future<String> signUp(GuestSignupInfo info) async {
    final fcmToken = await _fcmManager.getToken();
    final request = SignupRequestBody(
      deviceOs: DeviceOs.fromString(_deviceInfo.deviceOs),
      deviceId: const Uuid().v4(),
      deviceToken: fcmToken!,
      nickname: info.nickname,
    );
    final response = await _router.authRouter.guestSingUp(request);
    return response!.accessToken;
  }
}
