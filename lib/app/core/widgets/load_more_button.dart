import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:flutter/material.dart';

class LoadMoreButton extends StatelessWidget {
  final void Function() onTap;

  const LoadMoreButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenticBidsButton.text(
      text: "Load More",
      onTap: onTap,
    );
  }
}
