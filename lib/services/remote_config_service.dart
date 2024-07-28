import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  FirebaseRemoteConfigService._();

  static Future<void> initialize() async {
    try {
      await _remoteConfig.setDefaults(<String, dynamic>{
        'countryCode': 'US',
      });

      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 60), // Fetch timeout
        minimumFetchInterval: Duration.zero, // Minimum fetch interval
      ));

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print("Error: $e");
    }
  }

  static String getCountryCode() {
    return _remoteConfig.getString('countryCode') ?? "";
  }

  static Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print("Error: $e");
    }
  }
}
