import 'package:flutter/material.dart';
import 'package:posix/common/widgets/buttons/customButton.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _signinText() {
    return const Text("Sign in",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
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

  Widget _signinButton(BuildContext context) {
    return Custombutton(
        textStyle: AppTheme.appTheme.textTheme.bodyLarge!,
        text: "Validate",
        onPressed: () {
          print("button clicked");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            _signinText(),
            const SizedBox(
              height: 10,
            ),
            _emailField(),
            _passwordField(),
            _signinButton(context)
          ],
        ),
      ),
    );
  }
}
