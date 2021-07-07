import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageErrorView extends StatelessWidget {
  final String errorMsg;
  final String? optionalButtonText;
  final void Function()? optionalButtonOnTap;
  final bool _isOptionalButtonEnabled;

  const PageErrorView({
    Key? key,
    required this.errorMsg,
  })  : this._isOptionalButtonEnabled = false,
        this.optionalButtonOnTap = null,
        this.optionalButtonText = null,
        super(key: key);

  const PageErrorView.withOptionalButton({
    Key? key,
    required this.errorMsg,
    required this.optionalButtonOnTap,
    required this.optionalButtonText,
  })  : this._isOptionalButtonEnabled = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.margin.r * 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalSpace(),
              VerticalSpace(),
              CenticBidsText.headingOne("Whoops!"),
              VerticalSpace(),
              CenticBidsText.subheading(
                errorMsg,
                align: TextAlign.center,
              ),
              _isOptionalButtonEnabled ? _buildOptionalButton() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionalButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VerticalSpace(),
        VerticalSpace(),
        CenticBidsButton.text(
          text: optionalButtonText!,
          onTap: optionalButtonOnTap,
        ),
      ],
    );
  }
}
