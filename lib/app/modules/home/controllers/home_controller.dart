import 'package:firebase_authentication/app/data/models/user_model.dart';
import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthContoller authContoller = Get.find();
  late UserModel currentUser;
  @override
  void onInit() {
    super.onInit();
    currentUser = authContoller.loggedInUser;
  }
}
