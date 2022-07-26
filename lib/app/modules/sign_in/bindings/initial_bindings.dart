import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthContoller());
  }
}
