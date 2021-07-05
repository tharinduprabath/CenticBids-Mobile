import 'package:centic_bids/app/core/widgets/app_bar_bottom_with_heading.dart';
import 'package:flutter/material.dart';

class CenticBidsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const CenticBidsAppBar({
    Key? key,
    this.title = "",
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: AppBarBottomWithHeading(
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.5);
}
