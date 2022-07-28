import 'package:firebase_authentication/app/data/utils/image_util.dart';
import 'package:firebase_authentication/app/modules/profile/views/labeliconbotton.dart';
import 'package:firebase_authentication/app/modules/sign_in/views/input_field.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  final verticalSpace = const SizedBox(height: 20);
  final horizondalSpace = const SizedBox(width: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sign_bg.jpg'),
                fit: BoxFit.fill)),
        child: Column(children: [
          AppBar(
            backgroundColor: const Color(0x44ffffff),
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'Account',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          Expanded(
              child: Center(
            child: SingleChildScrollView(
              child: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              Semantics(
                                label: 'Choose image',
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Obx(
                                    () => CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            ImageUtil.getAvatharImage(
                                                controller.imageString.value)),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: -15,
                                child: Material(
                                  elevation: 2,
                                  color: const Color(0xAA2196F3),
                                  shape: const CircleBorder(),
                                  clipBehavior: Clip.hardEdge,
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        _pickImage();
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),
                        InputField(
                          controller: controller.fNameController,
                          hintText: 'First Name',
                          inputType: TextInputType.emailAddress,
                          validator: (val) => val != null && val.isNotEmpty
                              ? null
                              : 'Enter Name',
                          onChanged: (_) =>
                              controller.isValuesChanged.value = true,
                        ),
                        verticalSpace,
                        InputField(
                            controller: controller.lNameController,
                            hintText: 'Last Name',
                            inputType: TextInputType.emailAddress,
                            onChanged: (_) =>
                                controller.isValuesChanged.value = true),
                        verticalSpace,
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  primary: const Color(0xfffb6a69),
                                  shadowColor: const Color(0x77fb6a69)),
                              onPressed: controller.isValuesChanged.value
                                  ? () {
                                      controller.validate();
                                    }
                                  : null,
                              child: const Text('Submit'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ))
        ]),
      ),
    );
  }

  _pickImage() {
    showModalBottomSheet(
        context: Get.context!,
        barrierColor: const Color(0x33000000),
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            height: 170,
            decoration: BoxDecoration(
                color: const Color(0xBBFFFFFF),
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile photo',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelIconButton(
                        icon: Icons.camera_alt,
                        label: 'Camera',
                        onPress: () {
                          Get.back();
                          controller.choosePhoto(ImageSource.camera);
                        }),
                    LabelIconButton(
                        icon: Icons.image,
                        label: 'Gallery',
                        onPress: () {
                          Get.back();
                          controller.choosePhoto(ImageSource.gallery);
                        }),
                    LabelIconButton(
                        icon: Icons.delete,
                        label: 'Remove \n Photo',
                        iconColor: Colors.red,
                        onPress: () {
                          controller.removeImage();
                          Get.back();
                        })
                  ],
                )
              ],
            ),
          );
        });
  }
}
