import 'package:core/api/api_router.dart';
import 'package:features/home/domain/entities/committee_account.dart';
import 'package:features/home/domain/repositories/home_repository.dart';
import 'package:features/shared/domain/bill_thumbnail.dart';

class HomeRepositoryAdapter implements HomeRepository {

  final ApiRouter _router;

  HomeRepositoryAdapter(this._router);

  @override
  Future<HomeInfo> retrieve() async {
    final response = await _router.homeRouter.retrieveHome();
    return HomeInfo(
        subscriptions: response!.subscribeSection
            .subscribeLegislationBodies
            .map((subscription) => SubscribeCommitteeInfo(
              name: subscription.bodyType,
              legislationAccountNo: subscription.no,
              iconUrl: subscription.iconImageUrl))
            .toList(),
        thumbnails: response.todayBillPostSection
            .postThumbnails
            .map((thumbnail) => BillThumbnail(
              billId: thumbnail.billId,
              billName: thumbnail.billName,
              proposers: thumbnail.proposers)
        ).toList(),
        isNotificationArrived: response.isNotificationArrived
    );
  }
}