import 'package:features/home/domain/entities/committee_account.dart';
import 'package:features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeUseCase {

  final HomeRepository _homeRepository;

  GetHomeUseCase(this._homeRepository);

  Future<HomeInfo> execute() async {
    return await _homeRepository.retrieve();
  }
}