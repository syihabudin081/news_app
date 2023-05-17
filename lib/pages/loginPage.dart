// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:news_app/models/user.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/registerPage.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:news_app/db/database_helper.dart';

class LoginPageState extends StatefulWidget {
  const LoginPageState({super.key});

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<LoginPageState> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _goToHomePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future<void> _login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      final user = User.fromMap(users.first);
      final isValidPassword = await FlutterBcrypt.verify(
        password: password,
        hash: user.getPassword,
      );

      if (isValidPassword) {
        // Login successful, navigate to the home page or perform other actions.
        // Example: Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
        print('Login successful!');
        _goToHomePage(context);
      } else {
        // Invalid password
        print('Invalid password!');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Wrong Username/Password.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } else {
      // User not found
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Failed'),
          content: const Text('User not found.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      print('User not found!');
    }
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Login Page'),
      automaticallyImplyLeading: false, // hide back button
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 32.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: _login,
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                child: const Text('Register'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}