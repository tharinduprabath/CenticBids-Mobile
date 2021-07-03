import 'package:flutter/material.dart';

class PageLoadingView extends StatelessWidget {
  const PageLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
