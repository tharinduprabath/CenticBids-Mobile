import 'package:centic_bids/app/core/app_constants.dart';
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
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      content: Padding(
        padding: EdgeInsets.all(
          AppConstants.margin.r * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            CenticBidsText.headingOne(heading),
            VerticalSpace(),
            CenticBidsText.subheading(
              text,
            ),
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
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          Expanded(
            child: CenticBidsButton(
              onTap: action,
              text: actionButtonText,
              buttonType: useDestructiveNeutralButton
                  ? CenticBidsButtonType.destructive
                  : CenticBidsButtonType.primary,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CenticBidsButton(
              onTap: neutral,
              text: neutralButtonText!,
              buttonType: CenticBidsButtonType.secondary,
            ),
          ),
        ],
      ),
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

// class _DialogButton extends StatelessWidget {
//   final void Function()? onTap;
//   final String? text;
//   final bool isAction;
//
//   const _DialogButton(
//       {Key? key, required this.onTap, required this.text, this.isAction = true})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.maxFinite,
//         height: 32.h,
//         decoration: BoxDecoration(
//             color:
//                 isAction ? AppColors.black.withOpacity(0.9) : AppColors.white,
//             border: isAction
//                 ? null
//                 : Border.all(
//                     color: AppColors.black.withOpacity(0.9), width: 1)),
//         child: InkWell(
//             onTap: onTap,
//             child: Center(
//                 child: Text(
//               text ?? "",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: isAction ? AppColors.white : AppColors.black),
//             ))));
//   }
// }
