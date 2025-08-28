import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigInitializer {

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));

    await _remoteConfig.setDefaults(const {
      'isServerUnderMaintenance': false,
    });

    await _remoteConfig.fetchAndActivate();
  }
}