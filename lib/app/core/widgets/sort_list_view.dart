import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortListView extends StatefulWidget {
  final AuctionListSortType currentSortType;

  SortListView({
    Key? key,
    required this.currentSortType,
  }) : super(key: key);

  @override
  _SortListViewState createState() => _SortListViewState();
}

class _SortListViewState extends State<SortListView> {
  final NavigationService navigationService = sl();
  late AuctionListSortType userSelectedSortType;

  @override
  void initState() {
    super.initState();
    userSelectedSortType = widget.currentSortType;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(AppConstants.margin.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopEdgeLine(),
            VerticalSpace(),
            Align(
                alignment: Alignment.center,
                child: CenticBidsText.headingOne("Sort")),
            Divider(),
            VerticalSpace(),
            _buildSortItem(AuctionListSortType.remainingTimeUp),
            _buildSortItem(AuctionListSortType.remainingTimeDown),
            VerticalSpace(),
            Divider(),
            VerticalSpace(),
            CenticBidsButton(
              text: "Apply",
              onTap: () {
                navigationService.pop(userSelectedSortType);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopEdgeLine() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: 50.w,
          height: 2,
          color: AppColors.main_text_color,
        ));
  }

  Widget _buildSortItem(AuctionListSortType type) {
    final isActive = userSelectedSortType == type;

    late final icon;
    if (type == AuctionListSortType.remainingTimeUp)
      icon = Icons.arrow_upward_rounded;
    else
      icon = Icons.arrow_downward_rounded;

    return InkWell(
      onTap: () {
        setState(() {
          userSelectedSortType = type;
        });
      },
      child: ListTile(
        title: isActive ? _buildActive(icon) : _buildNotActive(icon),
        trailing: isActive
            ? Icon(
                Icons.check,
                size: AppConstants.icon_size.r,
                color: AppColors.primary_color,
              )
            : SizedBox(),
      ),
    );
  }

  Widget _buildActive(IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CenticBidsText.headingTwo("Remaining Time"),
        Icon(
          icon,
          color: AppColors.main_text_color,
          size: AppConstants.icon_size.r,
        )
      ],
    );
  }

  Widget _buildNotActive(IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CenticBidsText.headingTwo(
          "Remaining Time",
          color: AppColors.secondary_text_color,
        ),
        Icon(
          icon,
          color: AppColors.secondary_text_color,
          size: AppConstants.icon_size.r,
        )
      ],
    );
  }
}
