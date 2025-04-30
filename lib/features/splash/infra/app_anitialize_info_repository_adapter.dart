import 'package:front/core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:front/features/splash/domain/entities/app_initialize_info.dart';
import 'package:front/features/splash/domain/repositories/app_initialize_info_repository.dart';

class AppInitializeInfoRepositoryAdapter implements AppInitializeInfoRepository {

  final AppSettingsRepository _appSettingsRepository;

  AppInitializeInfoRepositoryAdapter(this._appSettingsRepository);

  @override
  Future<AppInitializeInfo> retrieve() async {
    bool isFirstLaunch = await _appSettingsRepository.isFirstLaunch();
    bool isLoggedIn = await _appSettingsRepository.isLoggedIn();
    return AppInitializeInfo(isFirstLaunch: isFirstLaunch, isLoggedIn: isLoggedIn);
  }
}