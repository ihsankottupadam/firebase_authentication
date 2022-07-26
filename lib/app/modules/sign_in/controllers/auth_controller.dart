import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthContoller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;

  User? get user => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, initScreen);
  }

  initScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.SIGN_IN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      Get.snackbar('Sign in Error', e.message ?? '',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 100));
    }
  }

  signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      Get.snackbar('Error creating account', e.message ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseException catch (e) {
      Get.snackbar('Unable to Sign Out', e.message ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
