import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeksites_task/screens/secret_screen.dart';

import '../utilities/utilities.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Utilities.screenHeight * 0.15,
              ),
              Form(
                key: _signInFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 30.0),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      hide: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 30.0),
                    const SizedBox(height: 30.0),
                    CustomButton(
                        text: 'Log in',
                        onTap: () async {
                          if (_signInFormKey.currentState!.validate()) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'Email', _emailController.text);
                            await prefs.setString(
                                'Password', _passwordController.text);
                            await prefs.setBool('isLoggedIn', true);

                            return Utilities().navigatTo(
                                context: context, screen: const SecretScreen());
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
