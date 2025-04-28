import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_theme.dart';

class CustomPasswordTextfield extends StatelessWidget {
  final TextEditingController textController;
  final bool isObscureText;
  final Function toggleIconButton;
  final bool isOnError;
  final String errorText;
  final String hintText;

  const CustomPasswordTextfield({
    super.key,
    required this.textController,
    required this.isObscureText,
    required this.toggleIconButton,
    required this.isOnError,
    required this.errorText,  this.hintText = 'Password',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      spacing: 5,
      children: [
        TextField(
          controller: textController,
          obscureText: isObscureText,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: IconButton(
                  onPressed: () => toggleIconButton,
                  icon: Icon(isObscureText
                      ? Icons.visibility_off_sharp
                      : Icons.visibility_rounded))),
        ),
        Visibility(
          visible: isOnError,
          child: Text(
            'Must not be empty',
            style: AppTheme.appTheme.textTheme.titleMedium!.copyWith(
              color: const Color.fromARGB(255, 255, 70, 70),
            ),
          ),
        )
      ],
    );
    ;
  }
}
