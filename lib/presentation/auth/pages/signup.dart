import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/common/widgets/buttons/custom_button.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';
import 'package:posix/domain/auth/usecases/signup.dart';
import 'package:posix/presentation/auth/pages/signin.dart';
import 'package:posix/service_locator.dart';

enum PasswordFieldType { password, confirmPassword }

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscurePassword = true;
  bool _isObscurePasswordConfirmation = true;

  _toggleObscuredPassword(PasswordFieldType fieldType) {
    setState(() {
      switch (fieldType) {
        case PasswordFieldType.password:
          _isObscurePassword = !_isObscurePassword;
          break;
        case PasswordFieldType.confirmPassword:
          _isObscurePasswordConfirmation = !_isObscurePasswordConfirmation;
          break;
      }
    });
  }

  Widget _signupText() {
    return Text(
      "Register",
      style: AppTheme.appTheme.textTheme.headlineLarge,
    );
  }

  Widget _pseudoField() {
    return TextField(
      controller: _pseudoController,
      decoration: const InputDecoration(hintText: "Pseudo"),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _isObscurePassword,
      decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: IconButton(
              onPressed: () =>
                  _toggleObscuredPassword(PasswordFieldType.password),
              icon: Icon(_isObscurePassword
                  ? Icons.visibility_off_sharp
                  : Icons.visibility_rounded))),
    );
  }

  Widget _confirmPasswordField() {
    return TextField(
      controller: _confirmPasswordController,
      obscureText: _isObscurePasswordConfirmation,
      decoration: InputDecoration(
          hintText: "Confirm password",
          suffixIcon: IconButton(
              onPressed: () =>
                  _toggleObscuredPassword(PasswordFieldType.confirmPassword),
              icon: Icon(_isObscurePasswordConfirmation
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_sharp))),
    );
  }

  Widget _signupButton(BuildContext context) {
    return Custombutton(
      text: "Register",
      onPressed: () async {
        await sl<SignupUseCase>().call(SignupRequestParams(
          email: _pseudoController.text,
          password: _passwordController.text,
        ));
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
                AppNavigation.push(context, SigninPage());
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
            _pseudoField(),
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
