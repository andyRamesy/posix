import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/common/widgets/buttons/custom_button.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';
import 'package:posix/presentation/auth/bloc/signup_cubit.dart';
import 'package:posix/presentation/auth/pages/signin.dart';
import 'package:posix/presentation/auth/widgets/custom_password_textfield.dart';
import 'package:posix/presentation/home/pages/home.dart';

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

  String _emptyUsername = '';
  bool _onEmptyUsername = false;

  String _emptyErrorMsg = '';
  bool _onEmpty = false;

  String _emptyConfirmPasswordErrorMsg = '';
  bool _onEmptyConfirmPassword = false;

  String _notMatchErrorMsg = '';
  bool _onNotMatchingConfirmPassword = false;

  bool _formHasError = false;

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
    return CustomTextField(
      hintText: 'Password',
      textController: _passwordController,
      isObscureText: _isObscurePassword,
      errorText: _emptyErrorMsg,
      isOnError: _onEmpty,
      fieldType: FieldType.password,
      toggleIconButton: () =>
          _toggleObscuredPassword(PasswordFieldType.password),
    );
  }

  Widget _confirmPasswordField() {
    return CustomTextField(
      textController: _confirmPasswordController,
      isObscureText: _isObscurePasswordConfirmation,
      errorText: _onNotMatchingConfirmPassword
          ? _notMatchErrorMsg
          : _emptyConfirmPasswordErrorMsg,
      isOnError: _onEmptyConfirmPassword || _onNotMatchingConfirmPassword,
      toggleIconButton: () =>
          _toggleObscuredPassword(PasswordFieldType.confirmPassword),
      hintText: 'Confirm password',
      fieldType: FieldType.password,
    );
  }

  bool _isNotvalidPassField() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String username = _pseudoController.text;

    setState(() {
      _onEmptyUsername = false;
      _onEmpty = false;
      _onEmptyConfirmPassword = false;
      _onNotMatchingConfirmPassword = false;
      _formHasError = false;

      _emptyUsername = '';
      _emptyErrorMsg = '';
      _emptyConfirmPasswordErrorMsg = '';
      _notMatchErrorMsg = '';

      if (username.isEmpty) {
        _emptyUsername = 'Username must not be empty';
        _onEmptyUsername = true;
        _formHasError = true;
      }

      if (password.isEmpty) {
        _emptyErrorMsg = 'password must not be empty';
        _onEmpty = true;
        _formHasError = true;
      }

      if (confirmPassword.isEmpty) {
        _emptyConfirmPasswordErrorMsg = 'confirm password must not be empty';
        _onEmptyConfirmPassword = true;
        _onNotMatchingConfirmPassword = true;
        _formHasError = true;
      }

      if (password != confirmPassword) {
        _notMatchErrorMsg = 'Confirm password do not match';
        _onNotMatchingConfirmPassword = true;
        _formHasError = true;
      }
    });
    return _formHasError;
  }

  Widget _signupButton(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        final isLoading = state is SignupLoading;
        return Custombutton(
          text: "Register",
          onPressed: () async {
            if (_isNotvalidPassField()) return;
            final params = SignupRequestParams(
              username: _pseudoController.text,
              password: _passwordController.text,
            );
            context.read<SignupCubit>().signup(params);
          },
          disabledButton: isLoading,
          textStyle: AppTheme.appTheme.textTheme.bodyLarge!,
        );
      },
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
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg)),
          );
        } else if (state is SignupSuccess) {
          AppNavigation.pushAndRemove(context, const HomePage());
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
