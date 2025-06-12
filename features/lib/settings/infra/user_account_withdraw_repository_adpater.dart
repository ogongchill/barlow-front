import 'package:core/api/api_router.dart';
import 'package:features/settings/domain/repositories/user_account_withdraw_repository.dart';

class UserAccountWithdrawRepositoryAdapter implements UserAccountWithdrawRepository{

  final ApiRouter _apiRouter;

  UserAccountWithdrawRepositoryAdapter(this._apiRouter);

  @override
  Future<void> withDraw() async {
    await _apiRouter.accountRouter.withdraw();
  }
}