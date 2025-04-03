import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/common/widgets/buttons/custom_button.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/presentation/auth/pages/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  void _toggleObscured() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Widget _signinText() {
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
      key: _passwordFieldKey,
      controller: _passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: IconButton(
              onPressed: _toggleObscured,
              icon: Icon(_isObscure
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_sharp))),
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

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Don't have account ? "),
          TextSpan(
            text: "Register",
            style: AppTheme.appTheme.textTheme.labelLarge,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigation.push(context, SignupPage());
              },
          )
        ],
      ),
    );
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
            _signinButton(context),
            const SizedBox(
              height: 5,
            ),
            _signupText(context)
          ],
        ),
      ),
    );
  }
}
