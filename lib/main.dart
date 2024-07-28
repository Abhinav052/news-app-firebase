import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newzbuzz/services/auth_service.dart';
import 'package:newzbuzz/services/remote_config_service.dart';
import 'package:newzbuzz/utils/routes/routes.dart';
import 'package:newzbuzz/utils/theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService.initialize();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getUserStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.theme,
            initialRoute: isLoggedIn ? Routes.homeScreen : Routes.loginScreen,
            onGenerateRoute: Routes.controller,
          );
        }
      },
    );
  }

  static Future<bool> _getUserStatus() async {
    return AuthService.checkLoginStatus();
  }
}
