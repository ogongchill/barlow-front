import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/dev/dummy-repository/dummy_cache.dart';
import 'package:front/features/committee/domain/repositories/commitee_notification_repository.dart';
import 'package:front/features/shared/domain/committee.dart';

class CommitteeNotificationRepositoryAdapter implements CommitteeNotificationRepository {

  final ApiRouter _apiRouter;
  final CommitteeNotificationCache _cache;

  CommitteeNotificationRepositoryAdapter(this._apiRouter, this._cache);

  @override
  Future<void> activateNotification(Committee committee)  async {
    _cache.add(committee, true);
    await _apiRouter.menuRouter.activateNotification(CommitteeLegislationType.of(committee));
  }

  @override
  Future<void> deactivateNotification(Committee committee) async {
    _cache.add(committee, false);
    await _apiRouter.menuRouter.deactivateNotification(CommitteeLegislationType.of(committee));
  }
}