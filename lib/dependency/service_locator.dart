import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/dio/dio_configs.dart';
import 'package:front/core/api/logger_interceptor.dart';
import 'package:front/core/database/notification/notification_read_status_repository_adapter.dart';
import 'package:front/core/utils/device_info_manager.dart';
import 'package:front/dev/dummy-repository/dummy_cache.dart';
import 'package:front/dev/dummy-repository/dummy_notification_repository.dart';
import 'package:front/dev/dummy-repository/dummy_preannounce_bill_detail_repository.dart';
import 'package:front/dev/dummy-repository/dummy_preannounce_bill_thumbnail_repository.dart';
import 'package:front/dev/dummy-repository/dummy_received_notification_repository.dart';
import 'package:front/dev/dummy-repository/dummy_token_repository.dart';
import 'package:front/dev/dummy-repository/dummy_user_repository.dart';
import 'package:front/features/bill_info/domain/usecases/fetch_recent_bill_thumbail_usecase.dart';
import 'package:front/features/bill_info/domain/usecases/get_bill_detail_usecase.dart';
import 'package:front/features/bill_info/infra/recent_bill_repository_adapter.dart';
import 'package:front/features/committee/domain/repositories/commitee_notification_repository.dart';
import 'package:front/features/committee/domain/repositories/committee_profile_repository.dart';
import 'package:front/features/committee/domain/repositories/committee_subscription_repository.dart';
import 'package:front/features/committee/domain/usecases/commitee_profile_usecase.dart';
import 'package:front/features/committee/domain/usecases/committee_bill_post_usecases.dart';
import 'package:front/features/committee/domain/usecases/committee_notification_usescase.dart';
import 'package:front/features/committee/domain/usecases/committtee_subscription_usecase.dart';
import 'package:front/features/committee/infra/commitee_profile_repository_adpater.dart';
import 'package:front/features/committee/infra/committee_bill_post_respository_adapter.dart';
import 'package:front/features/committee/infra/committee_notification_repository_adapter.dart';
import 'package:front/features/committee/infra/committee_subscription_repository_adapter.dart';
import 'package:front/features/home/domain/usecases/get_home_usecase.dart';
import 'package:front/features/home/infra/home_repository_adapters.dart';
import 'package:front/features/notification/domain/repositories/read_status_repository.dart';
import 'package:front/features/notification/domain/repositories/received_notification_repository.dart';
import 'package:front/features/notification/domain/usecases/fetch_received_notification_usecase.dart';
import 'package:front/features/notification/domain/usecases/notification_read_status_usecase.dart';
import 'package:front/features/pre_announce/domain/repositories/preannounce_bill_detail_respository.dart';
import 'package:front/features/pre_announce/domain/repositories/preannounce_bill_thumbnail_repository.dart';
import 'package:front/features/pre_announce/domain/usecases/fetch_preannounce_bill_detail_usecase.dart';
import 'package:front/features/pre_announce/domain/usecases/fetch_preannounce_thumbnail_usecase.dart';
import 'package:front/features/settings/domain/repositories/notification_repository.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';
import 'package:front/features/settings/domain/usecases/load_user_info_usecase.dart';
import 'package:front/features/settings/domain/usecases/notification_usecase.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {

  ///for home
  getIt.registerLazySingleton<GetHomeUseCase> (
      () => GetHomeUseCase(HomeRepositoryAdapter(getIt<ApiRouter>()))
  );

  /// for fetching bill detail
  // getIt.registerLazySingleton<BillDetailRepository>(
  //          () => DummyBillDetailRepositoryFactory.withSamples());
  // getIt.registerLazySingleton<GetBillDetailUseCase>(
  //          () => GetBillDetailUseCase(billDetailRepository: getIt<BillDetailRepository>()));
  getIt.registerLazySingleton<GetBillDetailUseCase>(
      () => GetBillDetailUseCase(billDetailRepository: BillDetailRepositoryAdapter(getIt<ApiRouter>()))
  );

  // recent bill thumbnails
  // getIt.registerLazySingleton<RecentBillRepository>(
  //     () => DummyRecentBillThumbnailRepository());
  // getIt.registerLazySingleton<FetchRecentBillThumbnailUseCase>(
  //     () => FetchRecentBillThumbnailUseCase(repository: getIt<RecentBillRepository>()));
  getIt.registerLazySingleton<FetchRecentBillThumbnailUseCase>(
          () => FetchRecentBillThumbnailUseCase(repository: RecentBillRepositoryAdapter(getIt<ApiRouter>()))
  );



  /// for fetching subscribe committee info with all committees
  getIt.registerLazySingleton<CommitteeSubscriptionRepository>(
          () => CommitteeSubscriptionRepositoryAdapter(getIt<ApiRouter>(), getIt<CommitteeSubscriptionCache>())
  );
  // getIt.registerLazySingleton<CommitteeSubscriptionRepository>(
  //         () => DummyCommitteeSubscriptionRepositoryFactory.withRandom(subscriptionCache: getIt<CommitteeSubscriptionCache>()));
  getIt.registerLazySingleton<FetchCommitteeSubscriptionUseCase>(
          () => FetchCommitteeSubscriptionUseCase(repository: getIt<CommitteeSubscriptionRepository>()));
  getIt.registerLazySingleton<ToggleCommitteeSubscriptionUseCase>(
          () => ToggleCommitteeSubscriptionUseCase(repository: getIt<CommitteeSubscriptionRepository>()));




  /// for fetching committee account profile
  getIt.registerLazySingleton<CommitteeNotificationRepository>(
          () => CommitteeNotificationRepositoryAdapter(getIt<ApiRouter>(), getIt<CommitteeNotificationCache>()));
  // getIt.registerLazySingleton<CommitteeProfileRepository>(
  //         () => DummyCommitteeProfileRepositoryFactory.withRandom(
  //           notificationCache: getIt<CommitteeNotificationCache>(),
  //           subscriptionCache: getIt<CommitteeSubscriptionCache>()
  //         ));
  getIt.registerLazySingleton<CommitteeProfileRepository>(
          () => CommitteeProfileRepositoryAdapter(getIt<ApiRouter>(), getIt<CommitteeNotificationCache>(), getIt<CommitteeSubscriptionCache>())
  );
  // getIt.registerLazySingleton<CommitteeBillPostRepository>(() => DummyCommitteeBillPostThumbnailRepository());
  // getIt.registerLazySingleton<FetchCommitteeBillPostThumbnailsUseCase> (
  //         () => FetchCommitteeBillPostThumbnailsUseCase(repository: getIt<CommitteeBillPostRepository>()));
  getIt.registerLazySingleton<FetchCommitteeBillPostThumbnailsUseCase> (
          () => FetchCommitteeBillPostThumbnailsUseCase(repository: CommitteeBillPostRepositoryAdapter(getIt<ApiRouter>())));



    /// usecases for profile view
  getIt.registerLazySingleton<FetchCommitteeProfileUseCase>(
      () => FetchCommitteeProfileUseCase(repository: getIt<CommitteeProfileRepository>()));
  // getIt.registerLazySingleton<ToggleCommitteeNotificationUseCase>(
  //         () => ToggleCommitteeNotificationUseCase(repository: getIt<CommitteeNotificationRepository>()));
  getIt.registerLazySingleton<ToggleCommitteeNotificationUseCase>(
            () => ToggleCommitteeNotificationUseCase(repository: getIt<CommitteeNotificationRepository>()));

  /// for caches
  getIt.registerLazySingleton<CommitteeNotificationCache>(() => CommitteeNotificationCache());
  getIt.registerLazySingleton<CommitteeSubscriptionCache>(() => CommitteeSubscriptionCache());

  // pre-announce
  getIt.registerLazySingleton<PreAnnounceBillThumbnailRepository>(
      () => DummyPreAnnounceBillThumbnailRepository());
  getIt.registerLazySingleton<FetchPreAnnounceThumbnailUseCase>(
      () => FetchPreAnnounceThumbnailUseCase(repository: getIt<PreAnnounceBillThumbnailRepository>()));
  getIt.registerLazySingleton<PreAnnounceBillDetailRepository>(
      () => DummyPreAnnounceBillDetailRepository());
  getIt.registerLazySingleton<FetchPreAnnounceBillDetailUseCase>(
      () => FetchPreAnnounceBillDetailUseCase(repository: getIt<PreAnnounceBillDetailRepository>()));

  //setting
  getIt.registerLazySingleton<UserRepository>(
      () => DummyUserInfoRepository());
  getIt.registerLazySingleton<LoadUserInfoUseCase>(
      () => LoadUserInfoUseCase(repository: getIt<UserRepository>()));
  getIt.registerLazySingleton<NotificationRepository> (
      () => DummyNotificationRepository());
  getIt.registerLazySingleton<ChangeNotificationUseCase>(
      () => ChangeNotificationUseCase(repository: getIt<NotificationRepository>()));
  getIt.registerLazySingleton<FetchNotificationUseCase>(
      () => FetchNotificationUseCase(repository: getIt<NotificationRepository>()));

  //notification
  getIt.registerLazySingleton<ReceivedNotificationRepository>(
      () => DummyReceivedNotificationRepository());
  getIt.registerLazySingleton<FetchReceivedNotificationUseCase>(
      () => FetchReceivedNotificationUseCase(repository: getIt<ReceivedNotificationRepository>()));
  getIt.registerLazySingleton<ReadStatusRepository>(
      () => NotificationReadStatusRepositoryAdapter());
  getIt.registerLazySingleton<MarkAsReadNotificationUseCase> (
      () => MarkAsReadNotificationUseCase(repository: getIt<ReadStatusRepository>()));
  getIt.registerLazySingleton<CheckIsReadNotificationUseCase> (
          () => CheckIsReadNotificationUseCase(repository: getIt<ReadStatusRepository>()));

  // for barlow-api
  getIt.registerLazySingleton<ApiRouter>(
      () => ApiRouter(
            apiClient: ApiClient(
              dioConfig: testServerConfig,
              deviceInfo: DeviceInfoManager(),
              tokenRepository: DummyTokenRepository(),
              interceptors: [LoggerInterceptor()]
            )
      )
  );
}

