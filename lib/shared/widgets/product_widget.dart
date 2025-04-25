import 'package:evencir_task/app/models/products_model.dart';
import 'package:evencir_task/app/modules/products/controllers/products_controller.dart';
import 'package:evencir_task/app/modules/products/pages/view_selected_product_page.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  final ProductsModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        await Get.find<ProductsController>().getProductFromID(product.id.toString()).then(
              (_) => Get.to(
                () => ViewSelectedProductPage(),
                transition: Transition.cupertino,
              ),
            );
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProductThumbnail(context),
            15.23.verticalSpace,
            _buildProductDescription(context),
            4.63.verticalSpace,
            _buildProductManufacturer(context),
            9.76.verticalSpace,
            _buildProductCategory(context),
            17.57.verticalSpace,
          ],
        ),
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

  Widget _buildProductDescription(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
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
          ),
        ),
        Text(
          "\$${product.price}",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: 14.sp, color: Color(0xFF0C0C0C)),
        ),
      ],
    );
  }

  Widget _buildProductManufacturer(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Text(
        "By ${product.brand}",
        textScaler: TextScaler.linear(1),
        style: AppTextStyles.poppinsRegular.copyWith(
          fontSize: 14.sp,
          color: Color(0xFF0C0C0C).withOpacity(0.50),
        ),
      ),
    );
  }

  Widget _buildProductCategory(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Text(
        "In ${product.category}",
        textScaler: TextScaler.linear(1),
        style: AppTextStyles.poppinsRegular.copyWith(fontSize: 14.sp, color: Color(0xFF0C0C0C)),
      ),
    );
  }
}
