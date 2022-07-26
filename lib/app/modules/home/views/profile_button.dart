import 'dart:convert';

import 'package:firebase_authentication/app/data/models/user_model.dart';
import 'package:firebase_authentication/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileButton extends GetWidget<HomeController> {
  ProfileButton({Key? key}) : super(key: key);
  final double appbarHeiht = AppBar().preferredSize.height;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        offset: Offset(0, AppBar().preferredSize.height - 10),
        child: _buildAvatar(),
        onSelected: (val) => _onPopSelect(val),
        itemBuilder: (context) {
          return [
            _buldAccoutInfo(),
            _buildPopUpItem('Account', Icons.account_box),
            _buildPopUpItem('Log Out', Icons.logout)
          ];
        });
  }

  PopupMenuItem _buildPopUpItem(String title, IconData icon) {
    return PopupMenuItem(
        value: title,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            Text(title)
          ],
        ));
  }

  PopupMenuItem _buldAccoutInfo() {
    final UserModel user = controller.currentUser;
    return PopupMenuItem(
        value: 'profile',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${user.firstName} ${user.lastName ?? ''}'),
                  const SizedBox(height: 5),
                  Text(
                    user.email!,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ));
  }

  _onPopSelect(selected) {
    switch (selected) {
      case 'Account':
        break;
      case 'Log Out':
        controller.authContoller.signOut();
        break;
      default:
    }
  }

  Widget _buildAvatar() {
    final UserModel currUser = controller.currentUser;
    String? imageString = currUser.imageString;
    final double preffWid = appbarHeiht - 20;
    return imageString == null
        ? Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(50)),
              width: preffWid,
              height: preffWid,
              child: Center(
                  child: Text(
                currUser.firstName![0],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: preffWid - 15,
                    color: Colors.white),
              )),
            ),
          )
        : Image.memory(
            base64Decode(currUser.imageString!),
            width: preffWid,
            height: preffWid,
            fit: BoxFit.contain,
          );
  }
}
