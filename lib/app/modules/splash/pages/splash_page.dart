import 'package:evencir_task/app/modules/splash/controllers/splash_controller.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:evencir_task/shared/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder:(_) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBackgroundImage(context),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Positioned.fill(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            colors: [
              Colors.transparent,
              Color(0xFF0C0C0C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(rect);
        },
        blendMode: BlendMode.darken,
        child: Image.asset(
          Assets.pngSplashBackground,
          fit: BoxFit.fill,
          cacheWidth: 200,
          cacheHeight: 200,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.only(
          top: 72.h,
          left: 38.w,
          right: 38.w,
          bottom: 133.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "My Store",
              textScaler: TextScaler.linear(1),
              style: AppTextStyles.playfairFontSemiBold.copyWith(
                color: Colors.black,
                fontSize: 50.sp,
              ),
            ),
            SizedBox(
              width: 285.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Valkommen",
                    textScaler: TextScaler.linear(1),
                    style: AppTextStyles.poppinsSemiBold.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.",
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1),
                    style: AppTextStyles.poppinsRegular.copyWith(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
