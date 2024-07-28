import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandlers {
  //FOR FIREBASE AUTH EXCEPTION
  static String handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "The email address is badly formatted.";
      case 'user-disabled':
        return "The user corresponding to the given email has been disabled.";
      case 'user-not-found':
        return "There is no user corresponding to the given email.";
      case 'wrong-password':
        return "The password is invalid for the given email.";
      case 'invalid-credential':
        return "The supplied auth credential is incorrect, malformed, or has expired.";
      case 'account-exists-with-different-credential':
        return "An account already exists with the same email address but different sign-in credentials.";
      case 'operation-not-allowed':
        return "Operation not allowed. Please contact support.";
      case 'too-many-requests':
        return "Too many requests. Please try again later.";
      default:
        return "An undefined error occurred.";
    }
  }
}
