import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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

  String get role {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.FirebaseAuth.instance.currentUser!.email)
        .snapshots();

    return "hi";
  }

  Stream<User?>? get user {
    return _firebaseauth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> SignInWithEmailandPassword(
      String email, String password) async {
    final credential = await _firebaseauth.signInWithEmailAndPassword(
        email: email, password: password);
    // print("snap data : ${credential.user}");

    return _userFromFirebase(credential.user);
  }

  Future<User?> SignUpWithEmailandPassword(
      String email, String password) async {
    final credential = await _firebaseauth.createUserWithEmailAndPassword(
        email: email, password: password);

    await FirebaseFirestore.instance.collection('users').doc(email).set({
      "email": email,
      "role": "user",
      "Uid": credential.user!.uid,
    });

    return _userFromFirebase(credential.user);
  }

  Future<void> Signout() async {
    await _firebaseauth.signOut();
  }
}
