import 'package:firebase_authentication/app/modules/home/views/profile_button.dart';
import 'package:firebase_authentication/app/modules/sign_in/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: const Text('Home'),
          actions: [ProfileButton(), const SizedBox(width: 20)],
        ),
        body: Container(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(controller.currentUser.firstName ?? 'null'),
              TextButton(
                  onPressed: () {
                    Get.find<AuthContoller>().signOut();
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
        ));
  }
}
