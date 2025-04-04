import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/common/widgets/buttons/custom_button.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/presentation/home/pages/home.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  void _toggleObscured() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Widget _signupText() {
    return Text(
      "Register",
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
      decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: IconButton(
              onPressed: _toggleObscured,
              icon: Icon(_isObscure
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_sharp))),
    );
  }

  Widget _confirmPasswordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
          hintText: "Confirm password",
          suffixIcon: IconButton(
              onPressed: _toggleObscured,
              icon: Icon(_isObscure
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_sharp))),
    );
  }

  Widget _signupButton(BuildContext context) {
    return Custombutton(
      text: "Register",
      onPressed: () {
        print("signup");
      },
      textStyle: AppTheme.appTheme.textTheme.bodyLarge!,
    );
  }

  Widget _siginText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Already have account ? "),
          TextSpan(
            text: "Signin",
            style: AppTheme.appTheme.textTheme.labelLarge,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigation.push(context, HomePage());
              },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            _signupText(),
            const SizedBox(
              height: 30,
            ),
            _emailField(),
            _passwordField(),
            _confirmPasswordField(),
            const SizedBox(
              height: 5,
            ),
            _signupButton(context),
            _siginText(context)
          ],
        ),
      ),
    );
  }
}
