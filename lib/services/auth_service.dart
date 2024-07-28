import 'package:fpdart/fpdart.dart';
import '../utils/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<Either<Failure, String>> register(
      {required String userName, required String email, required String password}) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user == null) {
        throw new Exception("Something went Wrong");
      }
      final resp = await _firestore.collection('users').doc(user.uid).set({
        'name': userName,
        'email': email,
      });
      return right("Success");
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, String>> login(
      {required String identifier, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: identifier,
        password: password,
      );
      User? user = result.user;
      if (user == null) {
        throw new Exception("Something went Wrong");
      }
      return right("Success");
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          return doc.data() as Map<String, dynamic>?;
        } else {
          print("User document does not exist");
        }
      } else {
        print("Not signed in");
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  static User? get currentUser {
    return _auth.currentUser;
  }

  static Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool checkLoginStatus() {
    User? user = currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }
}
