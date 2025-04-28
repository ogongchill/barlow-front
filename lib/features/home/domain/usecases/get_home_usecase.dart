import 'package:front/features/home/domain/entities/committee_account.dart';
import 'package:front/features/home/domain/repositories/home_repository.dart';

class GetHomeUseCase {

  final HomeRepository _homeRepository;

  GetHomeUseCase(this._homeRepository);

  Future<HomeInfo> execute() async {
    return await _homeRepository.retrieve();
  }
}