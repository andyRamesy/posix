import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_theme.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupPage({super.key});

  Widget _signupText() {
    return Text(
      "Sign in",
      style: AppTheme.appTheme.textTheme.headlineLarge,
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: "Email"),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: "Password"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
