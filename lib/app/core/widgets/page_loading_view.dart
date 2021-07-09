import 'package:centic_bids/app/core/design_system/centic_bids_loading_indicator.dart';
import 'package:flutter/material.dart';

class PageLoadingView extends StatelessWidget {
  const PageLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CenticBidsLoadingIndicator(),
    );
  }
}
