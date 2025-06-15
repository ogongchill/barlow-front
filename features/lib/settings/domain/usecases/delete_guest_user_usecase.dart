import 'package:core/database/secure-storage/token_repository.dart';
import 'package:core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:features/settings/domain/repositories/user_account_withdraw_repository.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:core/notification/firebase_manager.dart';
@injectable
class DeleteGuestUserUseCase {

  final UserInfoRepository _repository;
  final FcmManager _fireBaseManager;
  final AppSettingsRepository _appSettingsRepository;
  final TokenRepository _tokenRepository;
  final UserAccountWithdrawRepository _userAccountWithdrawRepository;

  DeleteGuestUserUseCase(this._repository, this._fireBaseManager, this._appSettingsRepository, this._tokenRepository, this._userAccountWithdrawRepository);

  Future<void> execute() async {
      await _repository.deleteUserInfo();
      await _appSettingsRepository.setFirstLaunch(true);
      await _userAccountWithdrawRepository.withDraw();
      await _tokenRepository.deleteAccessToken();
      await _retryWithBackoff(
            () async {
          await _fireBaseManager.deleteToken();
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