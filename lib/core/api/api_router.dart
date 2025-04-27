import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/legislation-account/legislation_account_router.dart';

import 'auth/auth_router.dart';
import 'home/home_router.dart';

class ApiRouter {

  final AuthRouter authRouter;
  final HomeRouter homeRouter;
  final LegislationAccountRouter legislationAccountRouter;

  ApiRouter({required ApiClient apiClient})
    : authRouter = AuthRouter(apiClient),
      homeRouter = HomeRouter(apiClient),
      legislationAccountRouter = LegislationAccountRouter(apiClient);
}