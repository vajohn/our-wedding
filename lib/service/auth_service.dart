import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/src/provider.dart';
import 'package:weddingrsvp/models/user_data.dart';
import 'package:weddingrsvp/providers/current_user.dart';
import 'package:weddingrsvp/util/router.gr.dart';

enum MessageType { success, error, info }

class AuthService {
  Future<void> emailRegistration(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _sendToast('The password provided is too weak.', 'info', context);
      } else if (e.code == 'email-already-in-use') {
        _sendToast(
            'The account already exists for that email.', 'error', context);
      }
    } catch (e) {
      print(e);
    } finally {
      Loader.hide();
    }
  }

  Future<bool> emailLogin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      updateUserData(userCredential.user);
      verifyAndLogin(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _sendToast('No user found for that email.', 'info', context);
      } else if (e.code == 'wrong-password') {
        _sendToast('Wrong password provided for that user.', 'error', context);
      }
    }

    return false;
  }

  // Future<bool> signInWithGoogle(BuildContext context) async {
  //   try {
  //     if (Platform.isAndroid) {
  //       // Trigger the authentication flow
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
  //         'email',
  //         'https://www.googleapis.com/auth/contacts.readonly',
  //       ]).signIn();
  //       // Obtain the auth details from the request
  //       final GoogleSignInAuthentication? googleAuth =
  //           await googleUser?.authentication;
  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken,
  //         idToken: googleAuth?.idToken,
  //       );
  //       // Once signed in, return the UserCredential
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //       updateUserData(userCredential.user);
  //     }
  //   } catch (e) {
  //     try {
  //       // Create a new providers
  //       GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //
  //       googleProvider
  //           .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //       googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
  //
  //       // Once signed in, return the UserCredential
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithPopup(googleProvider);
  //       updateUserData(userCredential.user);
  //     } catch (ex) {}
  //   }
  //
  //   verifyAndLogin(context);
  //   return false;
  // }
  //
  // Future<bool> signInWithFacebook(BuildContext context) async {
  //   try {
  //     // Trigger the sign-in flow
  //     if (Platform.isAndroid) {
  //       final LoginResult loginResult = await FacebookAuth.instance
  //           .login(permissions: ['public_profile', 'email']);
  //
  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithCredential(facebookAuthCredential);
  //
  //       updateUserData(userCredential.user);
  //     }
  //   } catch (e) {
  //     try {
  //       FacebookAuthProvider facebookProvider = FacebookAuthProvider();
  //
  //       facebookProvider.addScope('email');
  //       facebookProvider.setCustomParameters({
  //         'display': 'popup',
  //       });
  //
  //       // Once signed in, return the UserCredential
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithPopup(facebookProvider);
  //       updateUserData(userCredential.user);
  //     } catch (ex) {}
  //   }
  //   verifyAndLogin(context);
  //
  //   return false;
  // }

  void verifyAndLogin(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) if (!user.emailVerified) {
        context.read<CurrentUserData>().update(await getUserData(user.uid));
        AutoRouter.of(context).replace(AdminDashboardRouter());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Email verification has been resent',
            ),
          ),
        );
        await user.sendEmailVerification();
      }
    });
  }

  void _sendToast(String message, String messageType, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _toastColor(messageType),
      ),
    );
  }

  Future<void> updateUserData(User? user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot document = await users.doc(user?.uid).get();

    if (!document.exists) {
      users.doc(user?.uid).set({
        'roles': ['guest']
      });
    } else{

    }
  }

  Color _toastColor(String messageType) {
    switch (messageType) {
      case 'success':
        return Colors.green;
      case 'info':
        return Colors.lightBlue;
      case 'error':
        return Colors.redAccent;
      default:
        return Colors.black;
    }
  }

  phoneLogin(String phoneNumber, String text, BuildContext context) {

  }

  Future<UserData> getUserData(String uid) async {

    DocumentSnapshot<Map<String, dynamic>?> documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

     return UserData.fromJson(documentSnapshot.data());
  }
}
