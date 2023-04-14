import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeksites_task/screens/login_screen.dart';
import 'package:sleeksites_task/screens/secret_screen.dart';

late bool isLoggedIn;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleeksite Task',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: isLoggedIn ? const SecretScreen() : const LoginScreen(),
    );
  }
}
