import 'package:core/dependency/service_locator.dart';
import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/usecases/mark_as_reject_usecase.dart';
import 'package:features/splash/domain/usecases/get_store_url_usecase.dart';
import 'package:features/splash/domain/usecases/retrieve_app_initialize_info_usecase.dart';
import 'package:features/splash/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupUseCaseProvider = FutureProvider.family.autoDispose<void, String>((ref, nickname) async {
  return getIt<SignupUseCase>().execute(nickname);
});

class AppInitializeState {
  final bool needForceUpdate;
  final bool isFirstLaunch;
  final bool isLoggedIn;
  final bool hasCheckNotificationPermission;
  final bool isUpdateAvailable;
  final bool hasRejectUpdateDialog;
  final bool refreshFlag;

  const AppInitializeState({
    required this.needForceUpdate,
    required this.isFirstLaunch,
    required this.isLoggedIn,
    required this.hasCheckNotificationPermission,
    required this.isUpdateAvailable,
    required this.hasRejectUpdateDialog,
    required this.refreshFlag,
  });

  AppInitializeState copyWith({
    bool? needForceUpdate,
    bool? isFirstLaunch,
    bool? isLoggedIn,
    bool? hasCheckNotificationPermission,
    bool? isUpdateAvailable,
    bool? hasRejectUpdateDialog,
    bool? refreshFlag,
  }) {
    return AppInitializeState(
      needForceUpdate: needForceUpdate ?? this.needForceUpdate,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      hasCheckNotificationPermission: hasCheckNotificationPermission ?? this.hasCheckNotificationPermission,
      isUpdateAvailable: isUpdateAvailable ?? this.isUpdateAvailable,
      hasRejectUpdateDialog: hasRejectUpdateDialog ?? this.hasRejectUpdateDialog,
      refreshFlag: refreshFlag ?? this.refreshFlag,
    );
  }
}

final appInitializeStateProvider = StateNotifierProvider.autoDispose<AppInitializeInfoNotifier, AsyncValue<AppInitializeState>>(
      (ref) => AppInitializeInfoNotifier()
);

class AppInitializeInfoNotifier extends StateNotifier<AsyncValue<AppInitializeState>> {

  final RetrieveAppInitializeInfoUseCase _retrieveAppInitializeInfoUseCase = getIt<RetrieveAppInitializeInfoUseCase>();
  final MarkAsRejectUseCase _markAsRejectUseCase = getIt<MarkAsRejectUseCase>();

  AppInitializeInfoNotifier() : super(const AsyncLoading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final appInitializeInfo = await _retrieveAppInitializeInfoUseCase.execute();

      state = AsyncValue.data(AppInitializeState(
        needForceUpdate: appInitializeInfo.needForceUpdate,
        isUpdateAvailable: appInitializeInfo.isUpdateAvailable,
        hasRejectUpdateDialog: appInitializeInfo.hasRejectUpdateDialog,
        hasCheckNotificationPermission: appInitializeInfo.hasCheckNotificationPermission,
        isFirstLaunch: appInitializeInfo.isFirstLaunch,
        isLoggedIn: appInitializeInfo.isLoggedIn,
        refreshFlag: false,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markRejectUpdateDialog() async {
    await _markAsRejectUseCase.execute(UserRejectCategory.updateAvailableDialog);
    state = state.whenData((info) => info.copyWith(hasRejectUpdateDialog: true));
  }

  void setRefreshFlag() {
    state = state.whenData((data) => data.copyWith(refreshFlag: !data.refreshFlag));
  }
}

final storeUrlProvider = Provider<String>((ref) => getIt<GetStoreUrlUseCase>().execute());

final temporaryDisableUpdateNotifierProvider = StateNotifierProvider<TemporaryRejectUpdateNotifier, bool>(
    (ref) {
      ref.keepAlive();
      return TemporaryRejectUpdateNotifier();
    }
);

class TemporaryRejectUpdateNotifier extends StateNotifier<bool> {

  TemporaryRejectUpdateNotifier()
      : super(false);

  void execute() {
    state = true;
  }
}