import 'package:evencir_task/app/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(3.seconds, () {
      debugPrint('Process Completed, went to next page');
      Get.offAll(
        () => DashboardPage(),
        transition: Transition.cupertino,
      );
    });
  }
}
