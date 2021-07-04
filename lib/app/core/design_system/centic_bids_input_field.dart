import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenticBidsInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String placeholder;
  final IconData? leadingIcon, trailingIcon;
  final bool isPassword;
  final void Function()? trailingOnTap;
  final String? Function(String?)? validator;
  final void Function(String)? onSaved;

  CenticBidsInputField({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.validator,
    this.onSaved,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _CenticBidsInputFieldState createState() => _CenticBidsInputFieldState();
}

class _CenticBidsInputFieldState extends State<CenticBidsInputField> {
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
  );

  bool _isPasswordVisible = true;

  void _changePasswordVisible() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  final double iconSize = 20.r;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyles.body,
      obscureText: widget.isPassword ? _isPasswordVisible : false,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        if (widget.onSaved != null) widget.onSaved!(value!);
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.placeholder,
        contentPadding: const EdgeInsets.all(0),
        hintStyle:
            TextStyles.body.copyWith(color: AppColors.secondary_text_color),
        prefixIcon: widget.leadingIcon != null
            ? Icon(
                widget.leadingIcon,
                color: AppColors.main_text_color,
                size: iconSize,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.main_text_color,
                  size: iconSize,
                ),
                onPressed: _changePasswordVisible,
              )
            : widget.trailingIcon != null
                ? IconButton(
                    icon: Icon(
                      widget.trailingIcon,
                      color: AppColors.main_text_color,
                      size: iconSize,
                    ),
                    onPressed: widget.trailingOnTap,
                  )
                : null,
        border: _border.copyWith(
          borderSide: BorderSide(color: AppColors.outline_color, width: 2),
        ),
        errorBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.accent_color, width: 2),
        ),
        focusedBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.primary_color, width: 2),
        ),
        enabledBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.outline_color, width: 2),
        ),
      ),
    );
  }
}
