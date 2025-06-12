import 'package:core/api/account/account_router.dart';
import 'package:core/api/common/api_client.dart';
import 'package:core/api/legislation-account/legislation_account_router.dart';
import 'package:core/api/menu/menu_router.dart';
import 'auth/auth_router.dart';
import 'home/home_router.dart';
import 'pre-announce/pre_announce_router.dart';
import 'recent-bill/recent_bill_router.dart';
import 'version/version_check_router.dart';

class ApiRouter {

  final AuthRouter authRouter;
  final HomeRouter homeRouter;
  final LegislationAccountRouter legislationAccountRouter;
  final MenuRouter menuRouter;
  final PreAnnounceRouter preAnnounceRouter;
  final RecentBillRouter recentBillRouter;
  final VersionCheckRouter versionCheckRouter;
  final AccountRouter accountRouter;

  ApiRouter({required ApiClient apiClient})
    : authRouter = AuthRouter(apiClient),
      homeRouter = HomeRouter(apiClient),
      legislationAccountRouter = LegislationAccountRouter(apiClient),
      preAnnounceRouter = PreAnnounceRouter(apiClient),
      menuRouter = MenuRouter(apiClient),
      recentBillRouter = RecentBillRouter(apiClient),
      versionCheckRouter = VersionCheckRouter(apiClient),
      accountRouter = AccountRouter(apiClient);
}