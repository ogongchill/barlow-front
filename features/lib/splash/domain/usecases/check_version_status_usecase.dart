import 'package:features/splash/domain/entities/app_version_status.dart';
import 'package:features/splash/domain/repositories/app_version_status_repository.dart';

class CheckUpdateInfoUseCase {

  final AppVersionStatusRepository repository;

  CheckUpdateInfoUseCase(this.repository);

  Future<AppVersionStatus> check() async {
    return repository.fetchVersionInfo();
  }
}