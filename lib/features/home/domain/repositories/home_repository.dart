import 'package:front/features/home/domain/entities/committee_account.dart';

abstract interface class HomeRepository {

  Future<HomeInfo> retrieve();
}