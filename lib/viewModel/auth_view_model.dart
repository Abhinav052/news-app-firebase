import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newzbuzz/services/auth_service.dart';
import 'package:newzbuzz/services/user.service.dart';
import 'package:newzbuzz/utils/routes/routes.dart';
import 'package:newzbuzz/utils/shared_preferance/token_storage.dart';

class AuthViewModel extends ChangeNotifier {
  bool isAuthenticated = false;
  Map<String, dynamic> user = {};

  Future<void> login() async {
    if (AuthService.checkLoginStatus()) {
      isAuthenticated = true;
      notifyListeners();
    }
  }

  bool get getAuthenticationStatus => isAuthenticated;

  Future<void> logout() async {
    await TokenStorage.removeToken();
    user = {};
    isAuthenticated = false;
    notifyListeners();
  }

  Future<void> updateUserDetails(BuildContext context) async {
    final response = await UserService.getUser();
    response.fold((l) {
      logout();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
    }, (r) {
      // login(r);
    });
  }
}
