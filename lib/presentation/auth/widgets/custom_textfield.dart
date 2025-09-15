import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';

enum FieldType { password, text, number }

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final bool isObscureText;
  final VoidCallback? toggleIconButton;
  final bool isOnError;
  final String errorText;
  final String hintText;
  final FieldType fieldType;
  final bool hasError;

  const CustomTextField({
    super.key,
    required this.textController,
    this.isObscureText = false,
    this.toggleIconButton,
    required this.isOnError,
    required this.errorText,
    required this.fieldType,
    this.hintText = '',
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      spacing: 5,
      children: [
        Container(
          decoration: hasError
              ? BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.errorText)))
              : null,
          child: TextField(
            keyboardType: fieldType == FieldType.number
                ? TextInputType.phone
                : TextInputType.text,
            controller: textController,
            obscureText: isObscureText,
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: fieldType == FieldType.password
                    ? IconButton(
                        onPressed: toggleIconButton,
                        icon: Icon(isObscureText
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_sharp))
                    : null),
          ),
        ),
        isOnError
            ? Text(
                errorText,
                style: AppTheme.appTheme.textTheme.titleMedium!.copyWith(
                  color: const Color.fromARGB(255, 255, 70, 70),
                ),
              )
            : Container()
      ],
    );
  }
}
