import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pushReplacementNamed("MiddleOfHomeAndSignIn");

      return "Success";
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (e.code) {
        case "invalid-email":
          return "Your email address appears to be malformed.";
        case "wrong-password":
          return "Wrong password";

        case "user-not-found":
          return "User with this email doesn't exist.";

        case "user-disabled":
          return "User with this email has been disabled.";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      return "An Error occur";
    }
  }

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) async {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          notifyListeners();
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushReplacementNamed("MiddleOfHomeAndSignIn");
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set(
            {
              "name": name,
              "email": value.user!.email,
              "url": "",
              "status": "patient",
              "uid": uid,
            },
          );
        },
      );

      return "Success";
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (e.code) {
        case "weak-password":
          return "Your password is too weak";

        case "invalid-email":
          return "Your email is invalid";

        case "email-already-in-use":
          return "Email is already in use on different account";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      return "An Error occur";
    }
  }

  Future<String> signUpDoctor({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    required String contact,
    required String bmdcReg,
    required String nid,
    required String designation,
    required String specialization,
    required String fee,
    required String day,
    required String time,
    required String location,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          notifyListeners();
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushReplacementNamed("MiddleOfHomeAndSignIn");
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set(
            {
              "name": name,
              "email": value.user!.email,
              "url": "",
              "status": "doctor",
              "contact": contact,
              "bmdcReg": bmdcReg,
              "nid": nid,
              "designation": designation,
              "specialization": specialization,
              "fee": fee,
              "day": day,
              "time": time,
              "location": location,
              "uid": uid,
            },
          );
        },
      );

      return "Success";
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (e.code) {
        case "weak-password":
          return "Your password is too weak";

        case "invalid-email":
          return "Your email is invalid";

        case "email-already-in-use":
          return "Email is already in use on different account";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      return "An Error occur";
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future resetPassword({required String email}) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(
            email: email,
          )
          .timeout(
            const Duration(
              seconds: 5,
            ),
          );
      return "Success";
    } catch (e) {
      return "An Error occur";
    }
  }

  Future deleteUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .delete();
      user.delete();
    }
  }
}