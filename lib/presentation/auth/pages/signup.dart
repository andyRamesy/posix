import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/common/widgets/buttons/custom_button.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';
import 'package:posix/presentation/auth/bloc/signin_cubit.dart';
import 'package:posix/presentation/auth/bloc/signup_cubit.dart';
import 'package:posix/presentation/auth/pages/signin.dart';
import 'package:posix/presentation/auth/widgets/custom_textfield.dart';
import 'package:posix/presentation/home/pages/home.dart';
import 'package:posix/service_locator.dart';

enum PasswordFieldType { password, confirmPassword }

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _phonNumberController = TextEditingController();
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscurePassword = true;
  bool _isObscurePasswordConfirmation = true;

  String _emptyPhonNumber = '';
  bool _onEmptyPhonNumber = false;

  String _emptyUsername = '';
  bool _onEmptyUsername = false;
  

  String _emptyErrorMsg = '';
  bool _onEmpty = false;

  String _emptyConfirmPasswordErrorMsg = '';
  bool _onEmptyConfirmPassword = false;

  String _notMatchErrorMsg = '';
  bool _onNotMatchingConfirmPassword = false;

  bool _phonNumberHasError = false;
  bool _usernameHasError = false;
  bool _passwordHasError = false;
  bool _confirmPasswordHasError = false;
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

  Widget _phonNumberField() {
    return CustomTextField(
      textController: _phonNumberController,
      isOnError: _onEmptyPhonNumber,
      errorText: _emptyPhonNumber,
      hintText: "Phone number",
      fieldType: FieldType.text,
      hasError: _phonNumberHasError,
    );
  }

  Widget _pseudoField() {
    return CustomTextField(
      textController: _pseudoController,
      isOnError: _onEmptyUsername,
      errorText: _emptyPhonNumber,
      hintText: "Pseudo",
      fieldType: FieldType.text,
      hasError: _usernameHasError,
    );
  }

  Widget _passwordField() {
    return CustomTextField(
      hasError: _passwordHasError,
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
      hasError: _confirmPasswordHasError,
    );
  }

  bool _isNotvalidPassField() {
    String phonNumber = _phonNumberController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String username = _pseudoController.text;

    setState(() {
      _onEmptyUsername = false;
      _onEmpty = false;
      _onEmptyConfirmPassword = false;
      _onNotMatchingConfirmPassword = false;
      _onEmptyPhonNumber = false;
      _formHasError = false;

      _emptyPhonNumber = '';
      _emptyUsername = '';
      _emptyErrorMsg = '';
      _emptyConfirmPasswordErrorMsg = '';
      _notMatchErrorMsg = '';


      if(phonNumber.isEmpty){
        _emptyPhonNumber = 'Phone number must not be empty';
        _onEmptyPhonNumber = true;
        _phonNumberHasError = true;
      }

      if (username.isEmpty) {
        _emptyUsername = 'Username must not be empty';
        _onEmptyUsername = true;
        _usernameHasError = true;
      }

      if (password.isEmpty) {
        _emptyErrorMsg = 'password must not be empty';
        _onEmpty = true;
        _passwordHasError = true;
      }

      if (confirmPassword.isEmpty) {
        _emptyConfirmPasswordErrorMsg = 'confirm password must not be empty';
        _onEmptyConfirmPassword = true;
        _onNotMatchingConfirmPassword = true;
        _confirmPasswordHasError = true;
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
            print("phon number: ${_phonNumberController.text.length}");
            final params = SignupRequestParams(
              phonNumber: _phonNumberController.text,
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
                AppNavigation.push(
                    context,
                    BlocProvider(
                      create: (context) => sl<SigninCubit>(),
                      child: const SigninPage(),
                    ));
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
            SnackBar(
                content: Text(
              state.errorMsg,
              style: TextStyle(color: AppColors.errorText),
            )),
          );
        } else if (state is SignupSuccess) {
          AppNavigation.pushAndRemove(context, const HomePage());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                _signupText(),
                const SizedBox(
                  height: 30,
                ),
                _phonNumberField(),
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
      ),
    );
  }
}
