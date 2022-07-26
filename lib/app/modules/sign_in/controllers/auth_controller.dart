import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/app/data/models/user_model.dart';
import 'package:firebase_authentication/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthContoller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  late UserModel loggedInUser;

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
      Get.snackbar('Sign in Error', e.message ?? '',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 100));
      return false;
    }
    return false;
  }

  Future<bool> signUp(
      String email, String password, UserModel userModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _postToFirestore(userModel));
    } on FirebaseException catch (e) {
      Get.snackbar('Error creating account', e.message ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
    return false;
  }

  signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseException catch (e) {
      Get.snackbar('Unable to Sign Out', e.message ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  _postToFirestore(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .set(userModel.toJson());
    //toast
  }
}
