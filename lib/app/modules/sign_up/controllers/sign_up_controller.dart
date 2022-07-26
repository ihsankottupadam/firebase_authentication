import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();

  validate() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    Get.find<AuthContoller>()
        .signUp(emailController.text.trim(), passwordController.text);
  }
}
