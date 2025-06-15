import 'package:core/api/api_router.dart';
import 'package:core/database/cache.dart';
import 'package:features/committee/domain/repositories/commitee_notification_repository.dart';
import 'package:features/shared/domain/committee.dart';
import 'package:core/api/common/legislation_type.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CommitteeNotificationRepository)
class CommitteeNotificationRepositoryAdapter implements CommitteeNotificationRepository {

  final ApiRouter _apiRouter;
  final CommitteeNotificationCache _cache;

  CommitteeNotificationRepositoryAdapter(this._apiRouter, this._cache);

  @override
  Future<void> activateNotification(Committee committee)  async {
    _cache.add(committee, true);
    await _apiRouter.menuRouter.activateNotification(CommitteeLegislationType.of(committee.param));
  }

  @override
  Future<void> deactivateNotification(Committee committee) async {
    _cache.add(committee, false);
    await _apiRouter.menuRouter.deactivateNotification(CommitteeLegislationType.of(committee.param));
  }
}