import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CenticBidsButtonVariant {
  filled,
  outline,
  text,
  icon,
}

enum CenticBidsButtonType {
  primary,
  secondary,
  destructive,
}

class CenticBidsButton extends StatelessWidget {
  final String? _text;
  final IconData? _icon;
  final CenticBidsButtonVariant _buttonVariant;
  final bool isDisabled;
  final CenticBidsButtonType buttonType;
  final void Function()? onTap;

  const CenticBidsButton({
    Key? key,
    required String text,
    this.isDisabled = false,
    this.buttonType = CenticBidsButtonType.primary,
    this.onTap,
  })  : this._buttonVariant = CenticBidsButtonVariant.filled,
        this._text = text,
        this._icon = null,
        super(key: key);

  const CenticBidsButton.outline({
    Key? key,
    required String text,
    this.isDisabled = false,
    this.buttonType = CenticBidsButtonType.primary,
    this.onTap,
  })  : this._buttonVariant = CenticBidsButtonVariant.outline,
        this._text = text,
        this._icon = null,
        super(key: key);

  const CenticBidsButton.text({
    Key? key,
    required String text,
    this.isDisabled = false,
    this.buttonType = CenticBidsButtonType.primary,
    this.onTap,
  })  : this._buttonVariant = CenticBidsButtonVariant.text,
        this._text = text,
        this._icon = null,
        super(key: key);

  const CenticBidsButton.icon({
    Key? key,
    required IconData icon,
    this.isDisabled = false,
    this.buttonType = CenticBidsButtonType.primary,
    this.onTap,
  })  : this._buttonVariant = CenticBidsButtonVariant.icon,
        this._text = null,
        this._icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color fillColor = _buttonVariant != CenticBidsButtonVariant.filled
        ? AppColors.transparent
        : isDisabled
            ? AppColors.form_color
            : buttonType == CenticBidsButtonType.primary
                ? AppColors.primary_color
                : buttonType == CenticBidsButtonType.secondary
                    ? AppColors.form_color
                    : AppColors.accent_color;

    final Color outlineColor = _buttonVariant == CenticBidsButtonVariant.outline
        ? isDisabled || buttonType == CenticBidsButtonType.secondary
            ? AppColors.outline_color
            : buttonType == CenticBidsButtonType.primary
                ? AppColors.primary_color
                : AppColors.accent_color
        : AppColors.transparent;

    final Color childColor = isDisabled
        ? AppColors.secondary_text_color
        : buttonType == CenticBidsButtonType.primary
            ? _buttonVariant == CenticBidsButtonVariant.filled
                ? AppColors.white
                : AppColors.primary_color
            : buttonType == CenticBidsButtonType.destructive
                ? _buttonVariant == CenticBidsButtonVariant.filled
                    ? AppColors.white
                    : AppColors.accent_color
                : AppColors.main_text_color;

    final double? width = _buttonVariant == CenticBidsButtonVariant.text ||
            _buttonVariant == CenticBidsButtonVariant.icon
        ? null
        : double.maxFinite;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: AppConstants.animation_duration),
        width: width,
        height: 50.h,
        alignment: width == null ? null : Alignment.center,
        decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(AppConstants.radius.r),
            border: _buttonVariant == CenticBidsButtonVariant.outline
                ? Border.all(
                    color: outlineColor,
                    width: 2,
                  )
                : Border.fromBorderSide(BorderSide.none)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buttonVariant == CenticBidsButtonVariant.icon
                ? Icon(
                    _icon,
                    color: childColor,
                  )
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.margin.w),
                  child: CenticBidsText.body(
                      _text!,
                      color: childColor,
                      align: TextAlign.center,
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
