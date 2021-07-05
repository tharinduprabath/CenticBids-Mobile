import 'package:centic_bids/app/features/auctions/presentation/home/home_page_view_model.dart';
import 'package:centic_bids/app/features/auctions/presentation/home/widgets/centic_bids_drawer_bottom.dart';
import 'package:centic_bids/app/features/auctions/presentation/home/widgets/centic_bids_drawer_header.dart';
import 'package:centic_bids/app/features/auctions/presentation/home/widgets/drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DrawerUserLogged extends ViewModelWidget<HomePageViewModel> {
  const DrawerUserLogged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    return Drawer(
      child: Column(
        children: [
          CenticBidsDrawerHeader(
            title: model.getLocalUser()!.firstName,
          ),
          Expanded(
              child: ListView(
            children: [
              DrawerListItem(
                  icon: Icons.favorite_outline_rounded,
                  text: "My Bids",
                  onTap: model.goToMyBidsPage),
              DrawerListItem(
                  icon: Icons.lock_open_rounded,
                  text: "Change Password",
                  onTap: model.goToChangePasswordPage),
              DrawerListItem(
                  icon: Icons.logout_rounded,
                  text: "Logout",
                  onTap: model.showLogoutConfirmDialog),
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
