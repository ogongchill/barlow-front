import 'package:features/bill/domain/entities/committe_notification.dart';
import 'package:features/bill/domain/repositories/commitee_notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToggleCommitteeNotificationUseCase {

  final CommitteeNotificationRepository _repository;

  ToggleCommitteeNotificationUseCase({required CommitteeNotificationRepository repository})
    : _repository = repository;

  Future<void> execute(CommitteeNotification committeeNotification) async {
    if(committeeNotification.isActive) {
      return _repository.deactivateNotification(committeeNotification.committee);
    }
    return _repository.activateNotification(committeeNotification.committee);
  }
}