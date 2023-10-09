import 'package:flutter/material.dart';

Widget FormText(bool obscureText, String labelText, String hintText,
    BuildContext context, TextEditingController txtController, IconData icon) {
  return SizedBox(
    height: 70,
    width: MediaQuery.of(context).size.width - 30,
    child: TextFormField(
      controller: txtController,
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: hintText,
        labelText: labelText,
      ),
    ),
  );
}
