import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/app/data/models/user_model.dart';
import 'package:firebase_authentication/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthContoller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  late UserModel loggedInUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User? get user => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx(_auth.currentUser);

    _user.bindStream(_auth.userChanges());
    ever(_user, initScreen);
  }

  initScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed(Routes.SIGN_IN);
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) => loggedInUser = UserModel.fromJSON(value.data()!));

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((event) {
        loggedInUser = UserModel.fromJSON(event.data()!);
        update();
      });
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return false;
      });
    } on FirebaseException catch (e) {
      _showError('Error creating account', e.message);
      return false;
    }
    return false;
  }

  Future<bool> signUp(
      String email, String password, UserModel userModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => postToFirestore(userModel));
    } on FirebaseException catch (e) {
      _showError('Sign in error', e.message);
    }
    return false;
  }

  signInWithGoogle() async {
    try {
      final googleuser = await googleSignIn.signIn();
      if (googleuser == null) return;
      final googleAuth = await googleuser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth
          .signInWithCredential(credential)
          .then((val) => _initGoogleUser(googleuser));
    } on Exception catch (_) {
      _showError('Error creating account');
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
    } on FirebaseException catch (e) {
      _showError('Error signout', e.message);
    }
  }

  _initGoogleUser(googleuser) async {
    bool isDataExist = await _isUserDataInitialized(user!.uid);
    if (isDataExist) {
      return;
    }
    String? imageString = googleuser.photoUrl != null
        ? await _imageStringfromUrl(googleuser.photoUrl!)
        : null;
    await postToFirestore(UserModel(
        null, googleuser.email, googleuser.displayName, '', imageString));
  }

  Future postToFirestore(UserModel userModel) async {
    userModel.uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .set(userModel.toJson());
    //toast
  }

  Future<bool> _isUserDataInitialized(String uid) async {
    var a = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (a.exists) {
      return true;
    }
    return false;
  }

  Future<String?> _imageStringfromUrl(String? url) async {
    if (url == null) return null;
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    return base64Encode(bytes);
  }

  removeUserProfilePicture() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'imageString': ''});
  }

  _showError(String title, [String? message]) {
    Get.snackbar(title, message ?? '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xAAF44336),
        colorText: Colors.white);
  }
}
