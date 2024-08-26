import 'package:firebase_auth/firebase_auth.dart';
//import 'package:project_app/registration/login.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String>Login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "login ";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Unknown error occurred";
    } catch (e) {
      return "An error occurred: $e";
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Sign out error: $e");
    }
  }
}
