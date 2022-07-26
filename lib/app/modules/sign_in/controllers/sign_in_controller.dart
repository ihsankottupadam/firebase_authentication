import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  validate() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    Get.find<AuthContoller>()
        .signIn(emailController.text.trim(), passwordController.text.trim());
  }
}
