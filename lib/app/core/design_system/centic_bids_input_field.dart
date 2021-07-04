import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenticBidsInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isPassword;
  final void Function()? trailingOnTap;

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
  );

  CenticBidsInputField({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyles.body,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle:
            TextStyles.body.copyWith(color: AppColors.secondary_text_color),
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        prefixIcon: leadingIcon != null
            ? Icon(leadingIcon, color: AppColors.main_text_color)
            : null,
        suffixIcon: trailingIcon != null
            ? IconButton(
                icon: Icon(
                  trailingIcon,
                  color: AppColors.main_text_color,
                ),
                onPressed: trailingOnTap,
              )
            : null,
        border: _border.copyWith(
          borderSide: BorderSide(color: AppColors.outline_color),
        ),
        errorBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.accent_color),
        ),
        focusedBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.primary_color),
        ),
        enabledBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.outline_color),
        ),
      ),
    );
  }
}
