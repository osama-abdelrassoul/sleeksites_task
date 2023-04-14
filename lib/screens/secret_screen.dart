import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/utilities.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class SecretScreen extends StatelessWidget {
  const SecretScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SecretScreen"),
      ),
      body: Center(
        child: Center(
          child: CustomButton(
              text: 'Log out',
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('Email');
                await prefs.remove('Password');
                await prefs.remove('isLoggedIn');

                return Utilities()
                    .navigatTo(context: context, screen: const LoginScreen());
              }),
        ),
      ),
    );
  }
}
