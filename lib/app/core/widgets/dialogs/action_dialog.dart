import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/check_circle.dart';
import 'package:centic_bids/app/core/widgets/error_circle.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum _ActionDialogType { error, info, success }

class ActionDialog extends StatelessWidget {
  final String heading, text, actionButtonText;
  final String? neutralButtonText;
  final void Function() action;
  final void Function()? neutral;
  final bool useDestructiveNeutralButton;

  final _ActionDialogType _actionDialogType;

  const ActionDialog({
    Key? key,
    required this.text,
    required this.heading,
    required this.actionButtonText,
    required this.action,
    this.neutralButtonText,
    this.neutral,
    this.useDestructiveNeutralButton = false,
  })  : this._actionDialogType = _ActionDialogType.info,
        super(key: key);

  const ActionDialog.success({
    Key? key,
    required this.text,
    required this.heading,
    required this.actionButtonText,
    required this.action,
    this.neutralButtonText,
    this.neutral,
    this.useDestructiveNeutralButton = false,
  })  : this._actionDialogType = _ActionDialogType.success,
        super(key: key);

  const ActionDialog.error({
    Key? key,
    required this.text,
    required this.heading,
    required this.actionButtonText,
    required this.action,
    this.neutralButtonText,
    this.neutral,
    this.useDestructiveNeutralButton = false,
  })  : this._actionDialogType = _ActionDialogType.error,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.radius.r / 2))),
      content: Padding(
        padding: EdgeInsets.all(AppConstants.margin.r * 2
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            VerticalSpace(),
            CenticBidsText.headingOne(
              heading,
              align: TextAlign.center,
            ),
            VerticalSpace(),
            VerticalSpace(),
            CenticBidsText.subheading(
              text,
              align: TextAlign.center,
            ),
            VerticalSpace(),
            VerticalSpace(),
            VerticalSpace(),
            neutralButtonText == null
                ? _buildSingleButton()
                : _buildDoubleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.margin.w * 2),
      child: CenticBidsButton(
        onTap: action,
        text: actionButtonText,
      ),
    );
  }

  Widget _buildDoubleButton() {
    return Column(
      children: [
        CenticBidsButton(
          onTap: action,
          text: actionButtonText,
          buttonType: useDestructiveNeutralButton
              ? CenticBidsButtonType.destructive
              : CenticBidsButtonType.primary,
        ),
        VerticalSpace(),
        CenticBidsButton(
          onTap: neutral,
          text: neutralButtonText!,
          buttonType: CenticBidsButtonType.secondary,
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return _actionDialogType == _ActionDialogType.success
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: AppConstants.margin.h / 2),
            child: CheckCircle(
              size: AppConstants.margin.h * 2,
            ),
          )
        : _actionDialogType == _ActionDialogType.error
            ? Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppConstants.margin.h / 2),
                child: ErrorCircle(
                  size: AppConstants.margin.h * 2,
                ),
              )
            : SizedBox();
  }
}
