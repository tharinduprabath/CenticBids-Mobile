import 'package:cached_network_image/cached_network_image.dart';
import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:flutter/material.dart';

class FadeNetworkImage extends StatelessWidget {
  final String imageNetworkUrl;
  final BoxFit boxFit;

  FadeNetworkImage({
    Key? key,
    required this.imageNetworkUrl,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: AppColors.form_color,
      child: imageNetworkUrl.isEmpty ? SizedBox() : _buildNormalCacheImage(),
    );
  }

  Widget _buildNormalCacheImage() {
    return FadeInImage(
      placeholder: AssetImage(AppImages.logo_transparent,),
      imageErrorBuilder: (context, _, __) => SizedBox(),
      image: CachedNetworkImageProvider(
        imageNetworkUrl,
      ),
      fit: boxFit,
    );
  }
}
