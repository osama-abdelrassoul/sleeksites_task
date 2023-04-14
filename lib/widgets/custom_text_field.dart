import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_container.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  final bool hide;
  final TextInputType textInputType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLine = 1,
    this.hide = false,
    this.textInputType = TextInputType.emailAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginContainer(
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: textInputType,
        obscureText: hide,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 22, fontWeight: FontWeight.normal, color: Colors.white),
        decoration: InputDecoration(
          labelText: hintText,
          border: InputBorder.none,
          labelStyle: const TextStyle(color: Colors.green),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please Enter the $hintText';
          }
          return null;
        },
        maxLines: maxLine,
      ),
    );
  }
}
