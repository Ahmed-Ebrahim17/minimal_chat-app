import 'package:flutter/material.dart';
import 'package:minimal_1/services/auth/auth_service.dart';
import 'package:minimal_1/components/my_button.dart';
import 'package:minimal_1/components/my_textfield.dart';

import '../components/snakbar.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _pasController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signinWithEmailPassword(
          _emailController.text, _pasController.text);
    } catch (e) {
      showSnakBar(context, 'Invalid password or email.', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: _emailController,
                  text: 'Email',
                  obText: false,
                ),
                const SizedBox(
                  height: 14,
                ),
                MyTextField(
                  controller: _pasController,
                  text: 'Password',
                  obText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Login',
                  onTap: () => login(context),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
