import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

class AgeField extends StatelessWidget {
  final int? initialValue;
  final void Function(int?)? onChanged;
  final String? Function(String?)? validator; // 确保 validator 是正确的类型

  const AgeField({
    Key? key,
    this.initialValue,
    this.onChanged,
    this.validator, // 这里应该是 validator 的正确类型
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue?.toString(),
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppColors.textColor),
      decoration: const InputDecoration(
        labelText: 'Age',
        labelStyle: TextStyle(color: AppColors.textColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
      ),
      cursorColor: AppColors.textColor,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'\d')),
        LengthLimitingTextInputFormatter(3),
      ],
      validator: validator ??
          (value) {
            // 确保这里的参数和返回值类型都是 String?
            if (value == null || int.tryParse(value) == null) {
              return 'Please enter a valid age.';
            }
            int age = int.tryParse(value)!;
            if (age < 18 || age > 80) {
              return 'You must be at least 18 and at most 80 years old.';
            }
            return null; // 验证通过返回 null
          },
      onChanged: (value) {
        if (value != null) {
          int? parsedAge = int.tryParse(value);
          if (parsedAge != null) {
            onChanged?.call(parsedAge); // 确保 onChanged 接受 int?
          }
        }
      },
    );
  }
}
