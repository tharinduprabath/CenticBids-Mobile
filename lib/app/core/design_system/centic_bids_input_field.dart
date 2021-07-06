import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/text_styles.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenticBidsInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String placeholder;
  final IconData? leadingIcon, trailingIcon;
  final bool _isPassword, _isMoneyField;
  final void Function()? trailingOnTap;
  final String? Function(String?)? validator;
  final void Function(String)? onSaved;
  final TextInputType _inputType;

  CenticBidsInputField({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.validator,
    this.onSaved,
  })  : this._isMoneyField = false,
        this._inputType = TextInputType.text,
        this._isPassword = false,
        super(key: key);

  CenticBidsInputField.email({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.validator,
    this.onSaved,
  })  : this._isMoneyField = false,
        this._isPassword = false,
        this._inputType = TextInputType.emailAddress,
        super(key: key);

  CenticBidsInputField.personName({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.validator,
    this.onSaved,
  })  : this._isMoneyField = false,
        this._isPassword = false,
        this._inputType = TextInputType.name,
        super(key: key);

  CenticBidsInputField.password({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.validator,
    this.onSaved,
  })  : this._isMoneyField = false,
        this._isPassword = true,
        this._inputType = TextInputType.visiblePassword,
        super(key: key);

  CenticBidsInputField.money({
    Key? key,
    required MoneyMaskedTextController moneyMaskedTextController,
    this.placeholder = "",
    this.leadingIcon,
    this.trailingIcon,
    this.trailingOnTap,
    this.validator,
    this.onSaved,
  })  : this.controller = moneyMaskedTextController,
        this._isMoneyField = true,
        this._isPassword = false,
        this._inputType = TextInputType.number,
        super(key: key);

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

  final double iconSize = AppConstants.iconSize.r;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyles.body,
      obscureText: widget._isPassword ? _isPasswordVisible : false,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        if (widget.onSaved != null) widget.onSaved!(value!);
      },
      keyboardType: widget._inputType,
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
        suffixIcon: widget._isPassword
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
