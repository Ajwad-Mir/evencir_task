import 'package:evencir_task/app/modules/profile/controllers/profile_controller.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _buildTitle(context),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(vertical: 34.h, horizontal: 21.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileCard(context),
              63.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    _buildOptionTile(context, Assets.svgSettings, "Kontoinstallningar"),
                    26.verticalSpace,
                    _buildOptionTile(context, Assets.svgMinaBetaimtea, "Mina betalmetoder"),
                    26.verticalSpace,
                    _buildOptionTile(context, Assets.svgSupport, "Support"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Mitt konto',
      textScaler: TextScaler.linear(1),
      style: AppTextStyles.playfairFontSemiBold.copyWith(fontSize: 24.sp, color: Color(0xFF0C0C0C)),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: Color(0xFF0C0C0C),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildProfileImage(context),
          17.horizontalSpace,
          _buildProfileDetails(context),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      width: 65.w,
      height: 65.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ajwad Mir',
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsSemiBold.copyWith(
            fontSize: 14.sp,
            color: Color(0xFFF2F2F2),
          ),
        ),
        Text(
          'testaccount@gmail.com',
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsRegular.copyWith(
            fontSize: 10.sp,
            color: Color(0xFFF2F2F2),
          ),
        ),
        Text(
          '07XXXXXXXX',
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.poppinsRegular.copyWith(
            fontSize: 10.sp,
            color: Color(0xFFF2F2F2),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionTile(BuildContext context, String icon, String label) {
    return CupertinoButton(
      onPressed: () {},
      minSize: 0,
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: Get.width,
        height: 25.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
            ),
            19.horizontalSpace,
            Text(
              label,
              textScaler: TextScaler.linear(1),
              style: AppTextStyles.poppinsRegular.copyWith(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
