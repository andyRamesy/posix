import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/common/widgets/buttons/custom_button.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';
import 'package:posix/presentation/auth/bloc/signin_cubit.dart';
import 'package:posix/presentation/auth/bloc/signup_cubit.dart';
import 'package:posix/presentation/auth/pages/signup.dart';
import 'package:posix/presentation/auth/widgets/custom_password_textfield.dart';
import 'package:posix/presentation/home/pages/home.dart';
import 'package:posix/service_locator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  bool _onEmptyUsername = false;
  bool _onEmptyPassword = false;
  String _emptyUsernameErrorMsg = '';
  String _emptyPasswordErrorMsg = '';
  bool _formHasError = false;

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

  Widget _usernameField() {
    return CustomTextField(
      textController: _usernameController,
      isOnError: _onEmptyUsername,
      errorText: _emptyUsernameErrorMsg,
      hintText: "Pseudo",
      fieldType: FieldType.text,
      hasError: _formHasError,
    );
  }

  Widget _passwordField() {
    return CustomTextField(
      hasError: _formHasError,
      textController: _passwordController,
      isOnError: _onEmptyPassword,
      errorText: _emptyPasswordErrorMsg,
      fieldType: FieldType.password,
      isObscureText: _isObscure,
      toggleIconButton: _toggleObscured,
      hintText: 'Password',
    );
  }

  bool _isNotValidForm() {
    String pseudo = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      _onEmptyUsername = false;
      _onEmptyPassword = false;
      _formHasError = false;
      _emptyUsernameErrorMsg = '';
      _emptyPasswordErrorMsg = '';
      if (pseudo.isEmpty) {
        _onEmptyUsername = true;
        _emptyUsernameErrorMsg = 'Please enter your pseudo';
        _formHasError = true;
      }
      if (password.isEmpty) {
        _onEmptyPassword = true;
        _emptyPasswordErrorMsg = 'Please enter your password';
        _formHasError = true;
      }
    });
    return _formHasError;
  }

  Widget _signinButton(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      builder: (context, state) {
        final isLoading = state is SigninLoading;
        return Custombutton(
          textStyle: AppTheme.appTheme.textTheme.bodyLarge!,
          text: "Validate",
          onPressed: () {
            if (_isNotValidForm()) return;
            final params = SigninRequestParams(
                username: _usernameController.text,
                password: _passwordController.text);
            context.read<SigninCubit>().signin(params);
            print('valid form');
          },
          disabledButton: isLoading,
        );
      },
    );
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
                AppNavigation.push(
                    context,
                    BlocProvider(
                      create: (context) => sl<SignupCubit>(),
                      child: SignupPage(),
                    ));
              },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg)),
          );
        } else if (state is SigninSuccess) {
          AppNavigation.pushReplacement(context, HomePage());
        }
      },
      child: Scaffold(
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
              _usernameField(),
              _passwordField(),
              _signinButton(context),
              const SizedBox(
                height: 5,
              ),
              _signupText(context)
            ],
          ),
        ),
      ),
    );
  }
}
