import 'package:front/features/splash/domain/entities/app_version_status.dart';
import 'package:front/features/splash/domain/repositories/app_version_status_repository.dart';

class DummyAppVersionStatusRepository implements AppVersionStatusRepository {

  final AppVersionStatus returnStatus;

  DummyAppVersionStatusRepository(this.returnStatus);

  @override
  Future<AppVersionStatus> fetchVersionInfo() async {
    return returnStatus;
  }
}