import 'package:front/features/splash/domain/entities/app_initialize_info.dart';
import 'package:front/features/splash/domain/repositories/app_initialize_info_repository.dart';

class RetrieveAppInitializeInfoUseCase {

  final AppInitializeInfoRepository _repository;

  RetrieveAppInitializeInfoUseCase(this._repository);

  Future<AppInitializeInfo> execute() async {
    return _repository.retrieve();
  }
}