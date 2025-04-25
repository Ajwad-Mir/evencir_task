import 'package:evencir_task/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.tabs[controller.selectedIndex.value],
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      width: Get.width,
      height: 75.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
        color: Color(0xFF0C0C0C),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Obx(
            () => CupertinoButton(
              onPressed: () {
                controller.selectedIndex.value = index;
              },
              minSize: 0,
              padding: EdgeInsets.zero,
              pressedOpacity: 0.4,
              child: AnimatedContainer(
                duration: 250.milliseconds,
                curve: Curves.linear,
                width: 90.w,
                height: 75.h,
                decoration: BoxDecoration(
                    color: controller.selectedIndex.value == index
                        ? Color(0xFFF2F2F2).withAlpha((255 * 0.05).round())
                        : Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      controller.navBarItems.keys.elementAt(index),
                    ),
                    2.26.verticalSpace,
                    Text(
                      controller.navBarItems.values.elementAt(index),
                      textAlign: TextAlign.center,
                      textScaler: TextScaler.linear(1),
                      style: AppTextStyles.poppinsRegular.copyWith(
                        color: Color(0xFFF2F2F2),
                        fontSize: 10.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: controller.navBarItems.length,
      ),
    );
  }
}
