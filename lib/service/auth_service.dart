import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      try {
        // Create a new provider
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } catch (ex) {

      }
    }

    verifyAndLogin(context);
    return false;
  }

  Future<bool> signInWithFacebook(BuildContext context) async {
    try {
      // Trigger the sign-in flow
      if (Platform.isAndroid) {
        final LoginResult loginResult = await FacebookAuth.instance.login();

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      }
    } catch (e) {
      try {
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();

        facebookProvider.addScope('email');
        facebookProvider.setCustomParameters({
          'display': 'popup',
        });

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      } catch (ex) {}
    }
    verifyAndLogin(context);

    return false;
  }

  void verifyAndLogin(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) if (!user.emailVerified) {
        AutoRouter.of(context).replaceNamed('/login-screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Email verification has been resent'),
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
}
