import 'package:evencir_task/app/modules/categories/controllers/categories_controller.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:evencir_task/shared/widgets/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoriesPage extends GetView<CategoriesController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _buildTitle(context),
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 21.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSearchBar(context),
                10.verticalSpace,
                _buildFoundText(context),
                _buildCategoriesGrid(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Categories',
      textScaler: TextScaler.linear(1),
      style: AppTextStyles.playfairFontSemiBold.copyWith(fontSize: 24.sp, color: Color(0xFF0C0C0C)),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextFormField(
      controller: controller.categoriesSearchController,
      style: AppTextStyles.poppinsRegular.copyWith(
        fontSize: 12.sp,
        color: Color(0xFF0C0C0C),
      ),
      onChanged: (text) {
        controller.filteredCategories.clear();
        if (text.isEmpty) {
          return;
        }
        controller.filteredCategories.addAll(
            controller.categories.where((element) => element.name.toString().toLowerCase().contains(text)).toList());
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
          "${controller.categoriesSearchController.text.isEmpty ? controller.categories.length : controller.filteredCategories.length} results found",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsRegular.copyWith(
            fontSize: 10.sp,
            color: Color(0xFF0C0C0C).withValues(alpha: 255 * 0.25),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller.isCategoriesLoading.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0C0C0C),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: controller.categoriesSearchController.text.isEmpty
                    ? controller.categories.length
                    : controller.filteredCategories.length,
                addAutomaticKeepAlives: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return CategoriesWidget(
                    category: controller.categoriesSearchController.text.isEmpty
                        ? controller.categories[index]
                        : controller.filteredCategories[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
              ),
      ),
    );
  }
}
