import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/features/auction/presentation/home/home_page_view_model.dart';
import 'package:centic_bids/app/features/auction/presentation/home/widgets/centic_bids_drawer_bottom.dart';
import 'package:centic_bids/app/features/auction/presentation/home/widgets/centic_bids_drawer_header.dart';
import 'package:centic_bids/app/features/auction/presentation/home/widgets/drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DrawerUserNotLogged extends ViewModelWidget<HomePageViewModel> {
  const DrawerUserNotLogged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    return Drawer(
      child: Column(
        children: [
          CenticBidsDrawerHeader(),
          Expanded(
              child: ListView(
            children: [
              DrawerListItem(
                  icon: Icons.add_circle_outline,
                  text: "Join ${AppStrings.app_name}",
                  onTap: () =>
                      model.gotToLoginRegistrationPage(isSignInFirst: false)),
              DrawerListItem(
                  icon: Icons.login_rounded,
                  text: "Sign In",
                  onTap: () =>
                      model.gotToLoginRegistrationPage(isSignInFirst: true)),
              Divider(),
              DrawerListItem(
                  icon: Icons.info_outline_rounded,
                  text: "About",
                  onTap: model.goToAboutPage),
              DrawerListItem(
                  icon: Icons.privacy_tip_outlined,
                  text: "Privacy Policy",
                  onTap: model.goToPrivacyPolicyPage),
            ],
          )),
          CenticBidsDrawerBottom(),
        ],
      ),
    );
  }
}
