import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/widgets/image_container.dart';
import 'package:centic_bids/app/features/auction/presentation/auction/widgets/animated_circle_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrlList;
  final ValueNotifier<int> currentIndex = ValueNotifier(0);

  ImageSlider({
    Key? key,
    required this.imageUrlList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (index) => currentIndex.value = index,
          children: imageUrlList
              .map((e) => ImageContainer(
                    key: Key(e),
                    imageNetworkUrl: e,
                    fit: BoxFit.cover,
                    child: SizedBox(),
                  ))
              .toList(),
        ),
        IgnorePointer(
          child: Container(
            padding: EdgeInsets.only(right: AppConstants.margin.r / 2),
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: AppConstants.margin.r / 1.5),
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.margin.r / 1.5,
                  vertical: AppConstants.margin.r / 1.5),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radius.r)),
              child: ValueListenableBuilder<int>(
                valueListenable: currentIndex,
                builder: (context, index, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children:
                  List.generate(imageUrlList.length, (index) {
                    return AnimatedCircleDot(
                      color: index == currentIndex.value
                          ? AppColors.primary_color
                          : AppColors.secondary_text_color,
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
