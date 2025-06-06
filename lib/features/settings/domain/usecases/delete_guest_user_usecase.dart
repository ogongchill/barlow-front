import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:front/features/settings/domain/repositories/user_account_withdraw_repository.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';

class DeleteGuestUserUseCase {

  final UserInfoRepository _repository;
  final FirebaseMessaging _firebaseMessaging;
  final AppSettingsRepository _appSettingsRepository;
  final TokenRepository _tokenRepository;
  final UserAccountWithdrawRepository _userAccountWithdrawRepository;

  DeleteGuestUserUseCase(this._repository, this._firebaseMessaging, this._appSettingsRepository, this._tokenRepository, this._userAccountWithdrawRepository);

  Future<void> execute() async {
      await _repository.deleteUserInfo();
      await _appSettingsRepository.setFirstLaunch(true);
      await _userAccountWithdrawRepository.withDraw();
      await _tokenRepository.deleteAccessToken();
      await _retryWithBackoff(
            () async {
          await _firebaseMessaging.deleteToken();
        },
        maxRetries: 5,
        label: 'FCM 토큰 삭제',
      );
  }

  Future<void> _retryWithBackoff(
      Future<void> Function() task, {
        int maxRetries = 3,
        String label = '작업',
      }) async {
    int attempt = 0;
    int delaySeconds = 1;

    while (attempt < maxRetries) {
      try {
        await task();
        return; // 성공 시 탈출
      } catch (e) {
        attempt++;
        if (attempt >= maxRetries) {
          throw Exception('$label 실패 (최대 재시도 초과): $e');
        }
        await Future.delayed(Duration(seconds: delaySeconds));
        delaySeconds *= 2; // 1초 → 2초 → 4초
      }
    }
  }
}