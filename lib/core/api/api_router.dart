import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/legislation-account/legislation_account_router.dart';
import 'package:front/core/api/menu/menu_router.dart';
import 'package:front/core/api/pre-announce/pre_announce_router.dart';
import 'package:front/core/api/recent-bill/recent_bill_router.dart';
import 'package:front/core/api/version/version_check_router.dart';

import 'auth/auth_router.dart';
import 'home/home_router.dart';

class ApiRouter {

  final AuthRouter authRouter;
  final HomeRouter homeRouter;
  final LegislationAccountRouter legislationAccountRouter;
  final MenuRouter menuRouter;
  final PreAnnounceRouter preAnnounceRouter;
  final RecentBillRouter recentBillRouter;
  final VersionCheckRouter versionCheckRouter;

  ApiRouter({required ApiClient apiClient})
    : authRouter = AuthRouter(apiClient),
      homeRouter = HomeRouter(apiClient),
      legislationAccountRouter = LegislationAccountRouter(apiClient),
      preAnnounceRouter = PreAnnounceRouter(apiClient),
      menuRouter = MenuRouter(apiClient),
      recentBillRouter = RecentBillRouter(apiClient),
      versionCheckRouter = VersionCheckRouter(apiClient);
}