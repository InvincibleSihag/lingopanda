import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/network/connection_checker.dart';
import 'package:lingopanda/init_dependencies.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig){
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 2),
    ));
    _remoteConfig.setDefaults(const {
      countryKey: 'in',
    });
  }

  Future<void> initialize() async {
    try{
      if(await serviceLocator<ConnectionChecker>().isConnected){
        await _remoteConfig.fetchAndActivate();
      }
    } catch (e) {
      // print(e);
    }
  }

  String getRemoteConfigValue(String key) {
    return _remoteConfig.getString(key);
  }
}
