import 'package:evencir_task/app/models/categories_model.dart';
import 'package:evencir_task/app/modules/categories/controllers/categories_controller.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/modules/categories/pages/product_by_category_page.dart';

class CategoriesWidget extends StatelessWidget {
  final CategoriesModel category;

  const CategoriesWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Get.find<CategoriesController>().selectedCategory.value = category.name;
        Get.to(() => ProductByCategoryPage(),transition: Transition.cupertino);
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildProductThumbnail(context),
          ),
          Positioned(
            bottom: 5.h,
            left: 13.w,
            child: _buildProductDescription(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProductThumbnail(BuildContext context) {
    // return Image.network(
    //   category.url,
    //   cacheWidth: 200,
    //   cacheHeight: 200,
    //   loadingBuilder: (context, child, event) {
    //     if (event?.expectedTotalBytes == event?.cumulativeBytesLoaded) {
    //       return child;
    //     }
    //     return Center(
    //       child: CircularProgressIndicator(
    //         color: Color(0xFF0C0C0C),
    //       ),
    //     );
    //   },
    // ); //API Error: URL Stored show all products inside the categories so No Image For Overall Category As Suggested in Figma Design,
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        "https://wpmanageninja.com/wp-content/uploads/2018/06/Converting-Categories-into-Tags-in-WordPress-2048x1072.png",
        cacheWidth: 200,
        cacheHeight: 200,
        fit: BoxFit.fill,
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
      ),
    );
  }

  Widget _buildProductDescription(BuildContext context) {
    return Text(
      category.name,
      textScaler: TextScaler.linear(1),
      style: AppTextStyles.poppinsSemiBold.copyWith(
        fontSize: 14.sp,
        color: Color(0xFFFFFFFF),
      ),
    );
  }
}
