import 'package:firebase_authentication/app/data/models/user_model.dart';
import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  validate() async {
    if (!formKey.currentState!.validate() || isLoading.value) {
      return;
    }
    AuthContoller authContoller = Get.find();
    isLoading.value = true;
    UserModel userModel = UserModel(null, emailController.text,
        fNameController.text, lNameController.text, null);
    isLoading.value = await authContoller.signUp(
        emailController.text.trim(), passwordController.text, userModel);
  }
}
