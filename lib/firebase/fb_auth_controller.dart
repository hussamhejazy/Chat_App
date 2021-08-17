import 'package:chat_app/models/account.dart';
import 'package:chat_app/shared_preferences/shared_pref_controller.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'fb_firestore_controller.dart';

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  String getCurrentUserId(){
    return _firebaseAuth.currentUser!.uid;
  }
  Future<bool> createAccount(
    BuildContext context, {
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await FbFirebaseFirestoreController().createUser(
          id: userCredential.user!.uid,
          account: _getAccount(
              email: email, username: username, password: password));
      await AppPreferencesController().save(account: _getAccount(username: username, email: email, password: password));
      return true;
    } on FirebaseAuthException catch (e) {
      _controlErrorCodes(context, e);
    } catch (e) {
      print('Exception: $e');
    }
    return false;
  }

  Future<bool> signIn(
    BuildContext context, {
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await AppPreferencesController().save(account: _getAccount(username: username, email: email, password: password));
      return true;
    } on FirebaseAuthException catch (e) {
      _controlErrorCodes(context, e);
    } catch (e) {
      print('Exception: $e');
    }
    return false;
  }

  void _controlErrorCodes(
      BuildContext context, FirebaseAuthException authException) {
    showSnackBar(
        context: context, content: authException.message ?? '', error: true);
    switch (authException.code) {
      case 'email-already-in-use':
        break;

      case 'invalid-email':
        break;

      case 'operation-not-allowed':
        break;

      case 'weak-password':
        break;

      case 'user-not-found':
        break;

      case 'requires-recent-login':
        break;
    }
  }

  Account _getAccount({
    required String username,
    required String email,
    required String password,
  }) {
    Account account = Account();
    account.username = username;
    account.email = email;
    account.password = password;
    return account;
  }
}
