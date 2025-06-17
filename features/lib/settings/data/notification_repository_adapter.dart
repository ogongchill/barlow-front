import 'package:core/api/api_router.dart';
import 'package:features/settings/domain/entities/notification.dart';
import 'package:features/settings/domain/repositories/notification_repository.dart';
import 'package:features/bill/domain/constant/committee.dart';
import 'package:core/api/common/legislation_type.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryAdapter implements NotificationRepository {

  final ApiRouter _apiRouter;

  NotificationRepositoryAdapter(this._apiRouter);

  @override
  Future<void> activate(NotificationType notificationType) async {
    if(notificationType is CommitteeNotificationType) {
      CommitteeLegislationType committeeLegislationType = CommitteeLegislationType.of(Committee.findByName(notificationType.name).param);
      final response = await _apiRouter.menuRouter.activateNotification(committeeLegislationType);
      return;
    }
    throw UnimplementedError("other case of CommitteeNotificationType is not supported yet");
  }

  @override
  Future<void> deactivate(NotificationType notificationType) async{
    if(notificationType is CommitteeNotificationType) {
      CommitteeLegislationType committeeLegislationType = CommitteeLegislationType.of(Committee.findByName(notificationType.name).param);
      final response = await _apiRouter.menuRouter.deactivateNotification(committeeLegislationType);
      return;
    }
    throw UnimplementedError("other case of CommitteeNotificationType is not supported yet");
  }

  @override
  Future<Map<NotificationType, bool>> retrieve() async {
    Map<NotificationType, bool> notifications = {};
    final response = await _apiRouter.legislationAccountRouter.retrieveCommitteeAccounts();
    response!.accounts.forEach((account) {
      Committee committee = Committee.findByName(account.accountName);
      notifications[CommitteeNotificationType.of(committee)] = account.isNotifiable;
    });
    return notifications;
  }
}