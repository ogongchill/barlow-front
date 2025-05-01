import 'package:front/features/splash/domain/entities/app_initialize_info.dart';

abstract interface class AppInitializeInfoRepository {

  Future<AppInitializeInfo> retrieve();
}