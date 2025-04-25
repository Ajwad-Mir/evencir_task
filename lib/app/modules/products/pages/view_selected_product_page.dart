import 'package:evencir_task/app/models/products_model.dart';
import 'package:evencir_task/app/modules/products/controllers/products_controller.dart';
import 'package:evencir_task/app/services/favorite_items_service.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ViewSelectedProductPage extends GetView<ProductsController> {
  const ViewSelectedProductPage({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: _buildTitle(context),
          backgroundColor: Colors.white,
          leading: CupertinoButton(
            onPressed: () {
              Get.back();
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF0C0C0C),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 21.w),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProductThumbnail(context),
                  10.verticalSpace,
                  _buildProductTitle(context),
                  4.verticalSpace,
                  _buildProductDetails(context, title: "Name", value: controller.selectedProduct.value.title),
                  9.verticalSpace,
                  _buildProductDetails(context, title: "Price", value: "\$${controller.selectedProduct.value.price}"),
                  9.verticalSpace,
                  _buildProductDetails(context, title: "Category", value: controller.selectedProduct.value.category),
                  9.verticalSpace,
                  _buildProductDetails(context, title: "Brand", value: controller.selectedProduct.value.brand),
                  9.verticalSpace,
                  _buildProductRating(context, title: "Brand", rating: controller.selectedProduct.value.rating.toStringAsPrecision(2)),
                  9.verticalSpace,
                  _buildProductDetails(context, title: "Stock", value: controller.selectedProduct.value.stock.toString()),
                  9.verticalSpace,
                  _buildProductDescription(context),
                  9.verticalSpace,
                  _buildProductGallery(context),
                ],
              ),
            ),
          ),
        ),
      ),
      dispose: (_) {
        controller.selectedProduct.value = ProductsModel.empty();
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Products',
      textScaler: TextScaler.linear(1),
      style: AppTextStyles.playfairFontSemiBold.copyWith(fontSize: 24.sp, color: Color(0xFF0C0C0C)),
    );
  }

  Widget _buildProductThumbnail(BuildContext context) {
    return Image.network(
      controller.selectedProduct.value.thumbnail,
      width: Get.width,
      height: 210.h,
      cacheWidth: 200,
      cacheHeight: 200,
      loadingBuilder: (context, child, event) {
        if (event?.expectedTotalBytes == event?.cumulativeBytesLoaded) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: Color(0xFF0C0C0C),
          ),
        );
      },
    );
  }

  Widget _buildProductTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            "Product Details:",
            textScaler: TextScaler.linear(1),
            style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 14.sp, color: Color(0xFF0C0C0C)),
          ),
        ),
        CupertinoButton(
          onPressed: () {
            controller.handleFavoriteProduct(controller.selectedProduct.value);
            controller.update();
          },
          minSize: 0,
          padding: EdgeInsets.zero,
          child: Obx(
            () => SvgPicture.asset(
              Get.find<FavoriteItemService>().isFavorite(controller.selectedProduct.value.id) == true
                  ? Assets.svgFavoritesFilled
                  : Assets.svgFavorites,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductDetails(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return SizedBox(
      width: Get.width,
      child: RichText(
        textScaler: TextScaler.linear(1),
        text: TextSpan(
          text: "$title:   ",
          style: AppTextStyles.poppinsSemiBold.copyWith(
            fontSize: 10.sp,
            color: Color(0xFF0C0C0C),
          ),
          children: [
            TextSpan(
              text: value,
              style: AppTextStyles.poppinsRegular.copyWith(
                fontSize: 10.sp,
                color: Color(0xFF0C0C0C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductRating(
    BuildContext context, {
    required String title,
    required String rating,
  }) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "$title:   ",
              style: AppTextStyles.poppinsSemiBold.copyWith(
                fontSize: 10.sp,
                color: Color(0xFF0C0C0C),
              ),
              children: [
                TextSpan(
                  text: rating,
                  style: AppTextStyles.poppinsRegular.copyWith(
                    fontSize: 10.sp,
                    color: Color(0xFF0C0C0C),
                  ),
                ),
              ],
            ),
          ),
          StarRating(
            rating: controller.selectedProduct.value.rating,
            allowHalfRating: false,
            filledIcon: Icons.star_outlined,
            halfFilledIcon: Icons.star_half_outlined,
            color: Color(0xFFFFC553),
            borderColor: Color(0xFFFFC553),
            size: 11.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildProductDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Description:",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 10.sp, color: Color(0xFF0C0C0C)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            controller.selectedProduct.value.description,
            textScaler: TextScaler.linear(1),
            style: AppTextStyles.poppinsRegular.copyWith(fontSize: 10.sp, color: Color(0xFF0C0C0C)),
          ),
        )
      ],
    );
  }

  Widget _buildProductGallery(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Gallery:",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 10.sp, color: Color(0xFF0C0C0C)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: controller.selectedProduct.value.images.length,
          itemBuilder: (context, index) {
            return Image.network(
              controller.selectedProduct.value.images[index],
              width: 155.w,
              height: 110.h,
              cacheWidth: 200,
              cacheHeight: 200,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, event) {
                if (event?.expectedTotalBytes == event?.cumulativeBytesLoaded) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF0C0C0C),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
