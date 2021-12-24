import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:libman/Components/model/user.dart';

class Authservice {
  final auth.FirebaseAuth _firebaseauth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return User(user.uid, user.email);
    }
  }

  Stream<User?>? get user {
    return _firebaseauth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> SignInWithEmailandPassword(
      String email, String password) async {
    final credential = await _firebaseauth.signInWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(credential.user);
  }

  Future<void> Signout() async {
    await _firebaseauth.signOut();
  }
}
