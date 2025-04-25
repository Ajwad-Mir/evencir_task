import 'package:evencir_task/app/bindings/app_bindings.dart';
import 'package:evencir_task/app/modules/splash/pages/splash_page.dart';
import 'package:evencir_task/app/services/favorite_items_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(FavoriteItemService(),permanent: true);
    return ScreenUtilInit(
      designSize: Size(360, 800),
      child: GetMaterialApp(
        title: 'Evencir Test Task',
        debugShowCheckedModeBanner: false,
        initialBinding: AppBindings(),
        home: SplashPage(),
      ),
    );
  }
}