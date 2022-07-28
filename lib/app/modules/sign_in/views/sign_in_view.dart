import 'package:firebase_authentication/app/data/colors.dart';
import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:firebase_authentication/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';
import 'input_field.dart';

class SignInView extends GetView<SignInController> {
  final verticalSpace = const SizedBox(height: 20);
  final horizondalSpace = const SizedBox(width: 20);
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xFFDAABF1),

        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/sign_bg.jpg'),
              fit: BoxFit.fill)),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: controller.formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '  Sign in',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      verticalSpace,
                      InputField(
                        controller: controller.emailController,
                        hintText: 'Username',
                        inputType: TextInputType.emailAddress,
                        validator: (val) =>
                            val != null && GetUtils.isEmail(val.trim())
                                ? null
                                : 'Enter valid Email',
                      ),
                      verticalSpace,
                      InputField(
                        controller: controller.passwordController,
                        isPassword: true,
                        hintText: 'Password',
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : 'Enter password',
                      ),
                      verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              primary: const Color(0xfffb6a69),
                              shadowColor: const Color(0x77fb6a69)),
                          onPressed: () {
                            controller.validate();
                          },
                          child: Obx(
                            () => controller.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Sign in'),
                          ),
                        ),
                      ),
                      verticalSpace,
                      const Text(
                        'Or',
                        style: TextStyle(
                            color: MyColors.lightBlack,
                            fontWeight: FontWeight.w600),
                      ),
                      verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.find<AuthContoller>().signInWithGoogle();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color(0x77FFFFFF),
                                side: const BorderSide(
                                  color: Color(0x77ffffff),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/google-icon.png'),
                                horizondalSpace,
                                const Text('Continue with Google',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.lightBlack))
                              ],
                            )),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.SIGN_UP),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: RichText(
                              text: const TextSpan(
                                  text: 'Don\'t have account,  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.lightBlack),
                                  children: [
                                TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(color: Colors.blue))
                              ])),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    ));
  }
}
