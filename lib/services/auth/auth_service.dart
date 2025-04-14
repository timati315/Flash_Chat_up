import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //экземпляр аутентификации
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sing in
  Future<UserCredential> singInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sing up
  Future<UserCredential> singUpWithEmailAndPassword(
      String email, password) async {
    try {
      //creat
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //seve user info in a superate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid, 'email': email},
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
