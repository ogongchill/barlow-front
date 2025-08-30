import 'package:features/splash/domain/entities/app_version_status.dart';

abstract interface class AppVersionStatusRepository {

  Future<AppVersionStatus> fetchVersionInfo();

  Future<bool> fetchServerUnderMaintenanceInfo();
}