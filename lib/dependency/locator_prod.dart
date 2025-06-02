import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/dio/dio_configs.dart';
import 'package:front/core/database/notification/notification_read_status_repository_adapter.dart';
import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/database/setting/user_reject_hive_repository_adapter.dart';
import 'package:front/core/database/shared-preferences/share_prefs_terms_agreement_repository.dart';
import 'package:front/core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:front/core/database/shared-preferences/shared_prefs_system_permission_repository.dart';
import 'package:front/core/database/user/user_info_hive_repository.dart';
import 'package:front/core/utils/application_version_info.dart';
import 'package:front/core/utils/device_info_manager.dart';
import 'package:front/core/database/cache.dart';
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
import 'package:front/features/notification/domain/usecases/fetch_received_notification_usecase.dart';
import 'package:front/features/notification/domain/usecases/notification_read_status_usecase.dart';
import 'package:front/features/notification/infra/received_notification_respository_adapter.dart';
import 'package:front/features/pre_announce/domain/usecases/fetch_preannounce_bill_detail_usecase.dart';
import 'package:front/features/pre_announce/domain/usecases/fetch_preannounce_thumbnail_usecase.dart';
import 'package:front/features/pre_announce/infra/preannounce_bill_detail_repository_adapter.dart';
import 'package:front/features/pre_announce/infra/preannounce_bill_thumbnail_respository_adapter.dart';
import 'package:front/features/settings/domain/repositories/notification_repository.dart';
import 'package:front/features/settings/domain/repositories/user_reject_repository.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';
import 'package:front/features/settings/domain/usecases/check_reject_status_usecase.dart';
import 'package:front/features/settings/domain/usecases/delete_guest_user_usecase.dart';
import 'package:front/features/settings/domain/usecases/load_user_info_usecase.dart';
import 'package:front/features/settings/domain/usecases/mark_as_reject_usecase.dart';
import 'package:front/features/settings/domain/usecases/notification_usecase.dart';
import 'package:front/features/settings/infra/notification_repository_adapter.dart';
import 'package:front/features/splash/domain/repositories/auth_repository.dart';
import 'package:front/features/splash/domain/usecases/agree_terms_and_policies_usecase.dart';
import 'package:front/features/splash/domain/usecases/login_usecase.dart';
import 'package:front/features/splash/domain/usecases/mark_as_check_notification_permission_usecase.dart';
import 'package:front/features/splash/domain/usecases/request_notification_permission_usecase.dart';
import 'package:front/features/splash/domain/usecases/retrieve_app_initialize_info_usecase.dart';
import 'package:front/features/splash/domain/usecases/sign_up_usecase.dart';
import 'package:front/features/splash/infra/app_anitialize_info_repository_adapter.dart';
import 'package:front/features/splash/infra/auth_repository_adapter.dart';
import 'service_locator.dart';

Future<void> setUpProdLocator() async {

  ///for home
  getIt.registerLazySingleton<GetHomeUseCase> (
          () => GetHomeUseCase(HomeRepositoryAdapter(getIt<ApiRouter>()))
  );

  /// for fetching bill detail
  getIt.registerLazySingleton<GetBillDetailUseCase>(
          () => GetBillDetailUseCase(billDetailRepository: BillDetailRepositoryAdapter(getIt<ApiRouter>()))
  );
  getIt.registerLazySingleton<FetchRecentBillThumbnailUseCase>(
          () => FetchRecentBillThumbnailUseCase(repository: RecentBillRepositoryAdapter(getIt<ApiRouter>()))
  );

  /// for fetching subscribe committee info with all committees
  getIt.registerLazySingleton<CommitteeSubscriptionRepository>(
          () => CommitteeSubscriptionRepositoryAdapter(getIt<ApiRouter>(), getIt<CommitteeSubscriptionCache>())
  );
  getIt.registerLazySingleton<FetchCommitteeSubscriptionUseCase>(
          () => FetchCommitteeSubscriptionUseCase(repository: getIt<CommitteeSubscriptionRepository>()));
  getIt.registerLazySingleton<ToggleCommitteeSubscriptionUseCase>(
          () => ToggleCommitteeSubscriptionUseCase(repository: getIt<CommitteeSubscriptionRepository>()));

  /// for fetching committee account profile
  getIt.registerLazySingleton<CommitteeNotificationRepository>(
          () => CommitteeNotificationRepositoryAdapter(getIt<ApiRouter>(), getIt<CommitteeNotificationCache>()));
  getIt.registerLazySingleton<CommitteeProfileRepository>(
          () => CommitteeProfileRepositoryAdapter(getIt<ApiRouter>(), getIt<CommitteeNotificationCache>(), getIt<CommitteeSubscriptionCache>())
  );
  getIt.registerLazySingleton<FetchCommitteeBillPostThumbnailsUseCase> (
          () => FetchCommitteeBillPostThumbnailsUseCase(repository: CommitteeBillPostRepositoryAdapter(getIt<ApiRouter>())));

  /// usecases for profile view
  getIt.registerLazySingleton<FetchCommitteeProfileUseCase>(
          () => FetchCommitteeProfileUseCase(repository: getIt<CommitteeProfileRepository>()));
  getIt.registerLazySingleton<ToggleCommitteeNotificationUseCase>(
          () => ToggleCommitteeNotificationUseCase(repository: getIt<CommitteeNotificationRepository>()));

  /// for caches
  getIt.registerLazySingleton<CommitteeNotificationCache>(() => CommitteeNotificationCache());
  getIt.registerLazySingleton<CommitteeSubscriptionCache>(() => CommitteeSubscriptionCache());

  /// pre-announce
  getIt.registerLazySingleton<FetchPreAnnounceThumbnailUseCase>(
          () => FetchPreAnnounceThumbnailUseCase(repository: PreAnnounceBillThumbnailRepositoryAdapter(getIt<ApiRouter>())));
  getIt.registerLazySingleton<FetchPreAnnounceBillDetailUseCase>(
          () => FetchPreAnnounceBillDetailUseCase(repository: PreAnnounceBillDetailRepositoryAdapter(getIt<ApiRouter>())));

  ///setting
  getIt.registerLazySingleton<LoadUserInfoUseCase>(
          () => LoadUserInfoUseCase(repository: getIt<UserInfoRepository>()));
  getIt.registerLazySingleton<NotificationRepository> (
          () => NotificationRepositoryAdapter(getIt<ApiRouter>()));
  getIt.registerLazySingleton<ChangeNotificationUseCase>(
          () => ChangeNotificationUseCase(repository: getIt<NotificationRepository>()));
  getIt.registerLazySingleton<FetchNotificationUseCase>(
          () => FetchNotificationUseCase(repository: getIt<NotificationRepository>()));

  ///notification
  getIt.registerLazySingleton<FetchReceivedNotificationUseCase>(
          () => FetchReceivedNotificationUseCase(repository: ReceivedNotificationRepositoryAdapter(getIt<ApiRouter>())));
  getIt.registerLazySingleton<ReadStatusRepository>(
          () => NotificationReadStatusRepositoryAdapter());
  getIt.registerLazySingleton<MarkAsReadNotificationUseCase> (
          () => MarkAsReadNotificationUseCase(repository: getIt<ReadStatusRepository>()));
  getIt.registerLazySingleton<CheckIsReadNotificationUseCase> (
          () => CheckIsReadNotificationUseCase(repository: getIt<ReadStatusRepository>()));

  /// for splash : app 초기 진입
  getIt.registerLazySingleton<AuthRepository> (
          () => AuthRepositoryAdapter(
          router: getIt<ApiRouter>() ,
          deviceInfo: getIt<DeviceInfo>(),
          firebaseMessaging: FirebaseMessaging.instance));
  getIt.registerLazySingleton<LoginUseCase> (
          () => LoginUseCase(
          getIt<AuthRepository>(),
          getIt<TokenRepository>(),
          getIt<AppSettingsRepository>(),
          getIt<UserInfoRepository>()));
  getIt.registerLazySingleton<SignupUseCase>(
          () => SignupUseCase(
          getIt<AuthRepository>(),
          getIt<TokenRepository>(),
          getIt<AppSettingsRepository>(),
          getIt<UserInfoRepository>()
      ));
  getIt.registerLazySingleton<RetrieveAppInitializeInfoUseCase>(
          () => RetrieveAppInitializeInfoUseCase(AppInitializeInfoRepositoryAdapter(
              getIt<AppSettingsRepository>(),
              getIt<PermissionCheckStatusRepository>(),
              getIt<TokenRepository>()
          ))
  );

  /// for barlow-api
  getIt.registerLazySingleton<ApiRouter>(
          () => ApiRouter(
          apiClient: ApiClient(
              dioConfig: testServerConfig,
              deviceInfo: getIt<DeviceInfo>(),
              tokenRepository: getIt<TokenRepository>() ,
              interceptors: []
          )
      )
  );

  /// for service terms and policices
  final applicationInfoManager = await ApplicationVersionInfoManager.init();
  getIt.registerLazySingleton<TermsAgreementRepository>(() => TermsAgreementRepositoryAdapter());
  getIt.registerLazySingleton<CheckTermsAndPoliciesUseCase>(() => CheckTermsAndPoliciesUseCase(getIt<TermsAgreementRepository>()));
  getIt.registerLazySingleton<AgreeTermsAndPoliciesUseCase>(() => AgreeTermsAndPoliciesUseCase(getIt<TermsAgreementRepository>(), applicationInfoManager));

  /// for deleting userInfo
  getIt.registerLazySingleton<DeleteGuestUserUseCase>(() => DeleteGuestUserUseCase(
      getIt<UserInfoRepository>(),
      FirebaseMessaging.instance,
      getIt<AppSettingsRepository>(),
      getIt<TokenRepository>())
  );

  /// for device info
  getIt.registerLazySingleton<DeviceInfo> (() => DeviceInfoManager());
  getIt.registerLazySingleton<TokenRepository> (() => SecureStorageTokenRepository());
  getIt.registerLazySingleton<AppSettingsRepository> (() => SharedPrefsAppSettingRepository());
  getIt.registerLazySingleton<UserInfoRepository> (() => UserInfoHiveRepository());
  getIt.registerLazySingleton<PermissionCheckStatusRepository> (() => SharedPrefsPermissionCheckStatusRepository());

  ///for permissions
  getIt.registerLazySingleton<RequestNotificationPermissionUseCase>(() => RequestNotificationPermissionUseCase());
  getIt.registerLazySingleton<MarkAsCheckNotificationPermissionUseCase>(() => MarkAsCheckNotificationPermissionUseCase(repository: getIt<PermissionCheckStatusRepository>()));

  ///for user-reject status
  getIt.registerLazySingleton<UserRejectRepository>(() => UserRejectHiveRepositoryAdapter());
  getIt.registerLazySingleton<CheckUserRejectStatusUseCase>(() => CheckUserRejectStatusUseCase(repository: getIt<UserRejectRepository>()));
  getIt.registerLazySingleton<MarkAsRejectUseCase>(() => MarkAsRejectUseCase(repository: getIt<UserRejectRepository>()));
}

