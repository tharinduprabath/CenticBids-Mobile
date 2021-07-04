import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';

class BusyDialog extends StatelessWidget {
  final String text;

  const BusyDialog({Key? key, this.text = AppStrings.default_busy_msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      title: ListTile(
        title: CenticBidsText.headingThree(text),
        leading: CircularProgressIndicator(),
      ),
    );
  }
}
