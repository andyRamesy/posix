import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_theme.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> dropdownItems;
  final ValueChanged<String?> onDropdownChanged;
  final String? selectedValue;
  final String? hintText;
  final String labelText;

  const CustomDropdown(
      {super.key,
      required this.dropdownItems,
      required this.onDropdownChanged,
      this.selectedValue,
      this.hintText = 'Select an option',
      this.labelText = ''});

  @override
  Widget build(BuildContext context) {
    var textStyle = AppTheme.appTheme.textTheme.bodyLarge;
    return Row(
      children: [
        Text(
          labelText,
          style: AppTheme.appTheme.textTheme.bodyLarge!,
        ),
        DropdownButton<String>(
            hint: Text(
              hintText!,
              style: textStyle,
            ),
            value: dropdownItems.contains(selectedValue) ? selectedValue : null,
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: textStyle,),
              );
            }).toList(),
            onChanged: onDropdownChanged),
      ],
    );
  }
}
