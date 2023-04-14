// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeksites_task/utilities/utilities.dart';
import 'package:sleeksites_task/widgets/custom_button.dart';
import 'package:sleeksites_task/widgets/custom_text_field.dart';

late bool isLoggedIn ;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 isLoggedIn = await _checkIsLoggedIn();
  runApp(const MyApp());
}

Future<bool> _checkIsLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  return isLoggedIn ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleeksite Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? const SecretScreen() : const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
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
      appBar: AppBar(title: const Text("Login Screen"),backgroundColor: Colors.green, ),
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

                            return Utilities()
                                .navigatTo(context: context, screen: const SecretScreen());
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

class SecretScreen extends StatelessWidget {
  const SecretScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("SecretScreen"), ),
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
                    .navigatTo(context: context, screen: const _LoginForm());
              }),
        ),
      ),
    );
  }
}
