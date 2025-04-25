import 'package:evencir_task/app/modules/categories/controllers/categories_controller.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:evencir_task/shared/widgets/product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductByCategoryPage extends GetView<CategoriesController> {
  const ProductByCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      initState: (_) async{
        await controller.getProductBySelectedCategory();
      },
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _buildTitle(context),
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
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 21.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSearchBar(context),
              10.verticalSpace,
              _buildFoundText(context),
              20.verticalSpace,
              _buildProductsList(context),
            ],
          ),
        ),
      ),
      dispose: (_) {
        controller.selectedCategory.value = "";
        controller.products.clear();
        controller.filteredProducts.clear();
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

  Widget _buildSearchBar(BuildContext context) {
    return TextFormField(
      controller: controller.productSearchCategories,
      style: AppTextStyles.poppinsRegular.copyWith(
        fontSize: 12.sp,
        color: Color(0xFF0C0C0C),
      ),
      onChanged: (text) {
        controller.filteredProducts.clear();
        if (text.isEmpty) {
          return;
        }
        controller.filteredProducts.addAll(
            controller.products.where((element) => element.title.toString().toLowerCase().contains(text)).toList());
        controller.update();
      },
      decoration: InputDecoration(
        filled: false,
        constraints: BoxConstraints(
          maxWidth: Get.width,
          maxHeight: 33.h,
          minHeight: 33.h,
        ),
        hintText: 'Search',
        hintStyle: AppTextStyles.poppinsRegular.copyWith(
          fontSize: 12.sp,
          color: Color(0xFF0C0C0C).withOpacity(0.5),
        ),
        prefixIconConstraints: BoxConstraints(maxWidth: 50.w),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 13.68.w),
          child: SizedBox(
            height: 20.h,
            child: SvgPicture.asset(
              Assets.svgSearch,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1.w,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1.w,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _buildFoundText(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Obx(
            () => Text(
          "${controller.productSearchCategories.text.isEmpty ? controller.products.length : controller.filteredProducts.length} results found",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsRegular.copyWith(
            fontSize: 10.sp,
            color: Color(0xFF0C0C0C).withValues(alpha: 255 * 0.25),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList(BuildContext context) {
    return Expanded(
      child: Obx(
            () => controller.isProductLoading.isTrue
            ? Center(
          child: CircularProgressIndicator(
            color: Color(0xFF0C0C0C),
          ),
        )
            : ListView.separated(
          shrinkWrap: true,
          itemCount: controller.productSearchCategories.text.isEmpty
              ? controller.products.length
              : controller.filteredProducts.length,
          addAutomaticKeepAlives: true,
          itemBuilder: (context, index) {
            return ProductWidget(
              product: controller.productSearchCategories.text.isEmpty
                  ? controller.products[index]
                  : controller.filteredProducts[index],
            );
          },
          separatorBuilder: (context, index) {
            return 20.verticalSpace;
          },
        ),
      ),
    );
  }
}
