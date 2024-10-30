import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_1/services/auth/auth_service.dart';
import 'package:minimal_1/components/snakbar.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _pasController = TextEditingController();
  final _confirmPasController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});
  void register(BuildContext context) async {
    final authService = AuthService();
    if (_pasController.text == _confirmPasController.text) {
      try {
        await authService.createAccount(
            _emailController.text, _pasController.text);
      } on FirebaseAuthException catch (e) {
        showSnakBar(context, e.toString(), Colors.red);
      }
    } else {
      showSnakBar(context, "Passwords don't match", Colors.red);
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
                  size: 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Let\'s create an account for you',
                  style: TextStyle(
                    fontSize: 16,
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
                  height: 14,
                ),
                MyTextField(
                  controller: _confirmPasController,
                  text: 'Confirm password',
                  obText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Register',
                  onTap: () => register(context),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already member? ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
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
