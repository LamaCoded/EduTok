import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Controller/StateController/LoginStateController.dart';
import 'package:edutok/Controller/userController.dart';
import 'package:edutok/Screen/Profile.dart';
import 'package:edutok/Screen/Registration.dart';
import 'package:edutok/customComponent/global/FormText.dart';
import 'package:edutok/customComponent/profile/profileImage.dart';

import '../customComponent/global/BottomNav.dart';
import '../customComponent/global/Btn.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UserController userController = new UserController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                size: 35,
              ),
              onPressed: () => Get.back(),
            ),
            elevation: 0,
            title: Text(
              "Login",
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: 500,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormText(false, "Email", "Email", context, emailController,
                        Icons.person),
                    FormText(false, "Password", "password", context,
                        passwordController, Icons.password),
                    SizedBox(
                      height: 20,
                    ),
                    Btn("login", () {
                      if (checkValidation()) {
                        userController.login(
                            emailController, passwordController);
                      } else {
                        Get.snackbar("error:", "please try again later!");
                      }
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.off(Registration());
                        },
                        child: Text(
                          "Register?",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ]),
            ),
          ),
          bottomNavigationBar: Obx(() => ButtomNav(context))),
    );
  }

  bool checkValidation() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("error", "please fill all the field");
      return false;
    } else {
      return true;
    }
  }
}
