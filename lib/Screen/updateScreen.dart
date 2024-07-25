import 'package:edutok/customComponent/global/Btn.dart';
import 'package:edutok/customComponent/global/FormText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class upDateScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          height: 500,
          width: double.infinity,
          child: Column(children: [
            Spacer(),
            FormText(true, "Old Password:", "Old Password", context,
                oldPasswordController, Icons.password),
            FormText(true, "New Password:", "New Password", context,
                newPasswordController, Icons.password),
            SizedBox(
              height: 30,
            ),
            Btn("Update", () {}),
            Spacer(),
            FormText(true, "New Username:", "username", context,
                userNameController, Icons.person),
            SizedBox(
              height: 30,
            ),
            Btn("Update", () {}),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Note: You may not able to change your username for 14 days again",
                textAlign: TextAlign.center,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
