import 'dart:io';

import 'package:firebase_authentication/app/data/models/user_model.dart';
import 'package:firebase_authentication/app/data/utils/image_util.dart';
import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final AuthContoller authContoller = Get.find();
  RxString imageString = ''.obs;
  late UserModel currUser;
  RxBool isValuesChanged = false.obs;

  @override
  void onInit() {
    currUser = authContoller.loggedInUser;
    fNameController.text = currUser.firstName!;
    lNameController.text = currUser.lastName ?? '';
    imageString.value = currUser.imageString ?? '';
    super.onInit();
  }

  validate() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    currUser
      ..firstName = fNameController.text
      ..lastName = lNameController.text
      ..imageString = imageString.value;
    authContoller.postToFirestore(currUser).then((value) => Get.snackbar(
          'Details updated successfully',
          '',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        ));
  }

  choosePhoto(source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 500);

    if (image == null) return;
    File imageFile = File(image.path);
    imageString.value = ImageUtil.imageToString(imageFile);
    isValuesChanged.value = true;
  }

  removeImage() async {
    imageString.value = '';
    authContoller.removeUserProfilePicture();
  }
}
