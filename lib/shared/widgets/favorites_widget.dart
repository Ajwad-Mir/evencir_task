import 'package:evencir_task/app/models/products_model.dart';
import 'package:evencir_task/app/modules/favorites/controllers/favories_controller.dart';
import 'package:evencir_task/app/services/favorite_items_service.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FavoritesWidget extends StatelessWidget {
  final ProductsModel product;

  const FavoritesWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 13.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border(
          left: BorderSide(
            color: Color(0xFF0C0C0C).withOpacity(0.05),
            width: 1.w,
          ),
          right: BorderSide(
            color: Color(0xFF0C0C0C).withOpacity(0.05),
            width: 1.w,
          ),
          bottom: BorderSide(
            color: Color(0xFF0C0C0C).withOpacity(0.05),
            width: 1.w,
          ),
          top: BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProductThumbnail(context),
          15.23.horizontalSpace,
          Expanded(child: _buildFavoriteDescription(context)),
          9.76.horizontalSpace,
          _buildFavoriteButton(context),
        ],
      ),
    );
  }

  Widget _buildProductThumbnail(BuildContext context) {
    return Image.network(
      product.thumbnail,
      cacheWidth: 200,
      cacheHeight: 200,
      loadingBuilder: (context, child, event) {
        if (event?.expectedTotalBytes == event?.cumulativeBytesLoaded) {
          return Container(
            width: 65.w,
            height: 65.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent
            ),
            child: child,
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Color(0xFF0C0C0C),
          ),
        );
      },
    );
  }

  Widget _buildFavoriteDescription(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          product.title,
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 14.sp, color: Color(0xFF0C0C0C)),
        ),
        Text(
          "\$${product.price}",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 14.sp, color: Color(0xFF0C0C0C)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.rating.toStringAsPrecision(2),
              textScaler: TextScaler.linear(1),
              style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 14.sp, color: Color(0xFF0C0C0C)),
            ),
            3.horizontalSpace,
            StarRating(
              rating: product.rating,
              allowHalfRating: false,
              filledIcon: Icons.star_outlined,
              halfFilledIcon: Icons.star_half_outlined,
              color: Color(0xFFFFC553),
              borderColor: Color(0xFFFFC553),
              size: 11.sp,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Get.find<FavoritesController>().handleFavoriteProduct(product);
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Obx(
        () => SvgPicture.asset(
          Get.find<FavoriteItemService>().isFavorite(product.id) == true
              ? Assets.svgFavoritesFilled
              : Assets.svgFavorites,
        ),
      ),
    );
  }
}
