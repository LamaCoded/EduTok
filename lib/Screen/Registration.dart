import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Screen/login.dart';
import 'package:edutok/customComponent/global/Btn.dart';
import 'package:edutok/customComponent/global/FormText.dart';

import '../Controller/userController.dart';

class Registration extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController userTextController = TextEditingController();

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
          centerTitle: true,
          title: Text("Register"),
          elevation: 0,
        ),
        body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FormText(false, "Email", "Email", context, emailController,
                Icons.person),
            FormText(false, "Password", "Password", context, passwordController,
                Icons.password),
            FormText(false, "Age", "Age", context, AgeController,
                Icons.child_care_sharp),
            FormText(false, "username", "username", context, userTextController,
                Icons.child_care_sharp),
            SizedBox(
              height: 20,
            ),
            Btn("Register", () {
              if (checkValidation()) {
                userController.Registration(emailController, passwordController,
                    AgeController, userTextController);
              } else {
                Get.snackbar("error:", "Please try again later!");
              }
            }),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => Get.to(Login()),
                child: Text(
                  "Login?",
                  style: TextStyle(color: Colors.blue),
                ))
          ]),
        ),
      ),
    );
  }

  bool checkValidation() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("error", "please fill all the field");
      return false;
    } else if (!emailController.text.isEmail ||
        !isPassword(passwordController.text)) {
      Get.snackbar(
          "Input Error", "please check emailformat or password format");
      return false;
    } else {
      return true;
    }
  }

  bool isPassword(String input) {
    final pattern = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return pattern.hasMatch(input);
  }
}
