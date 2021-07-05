import 'package:cached_network_image/cached_network_image.dart';
import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageNetworkUrl;
  final Widget child;
  final BoxFit fit;

  ImageContainer({
    Key? key,
    required this.imageNetworkUrl,
    this.fit = BoxFit.fill,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Container(
            color: AppColors.form_color,
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: _buildNormalCacheImage(),
          ),
          _buildChild(),
        ],
      ),
    );
  }

  Widget _buildNormalCacheImage() {
    return FadeInImage(
      placeholder: AssetImage(AppImages.logo_transparent),
      imageErrorBuilder: (context, _, __) => Container(
        width: double.maxFinite,
        height: double.maxFinite,
      ),
      image: CachedNetworkImageProvider(
        imageNetworkUrl,
      ),
      fit: fit,
    );
  }

  Widget _buildChild() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: AppColors.transparent,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: child,
      ),
    );
  }
}
