import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig){
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 2),
    ));
    _remoteConfig.setDefaults(const {
      'country': 'in',
    });
  }

  Future<void> initialize() async {
    await _remoteConfig.fetchAndActivate();
  }

  String getRemoteConfigValue(String key) {
    return _remoteConfig.getString(key);
  }
}
