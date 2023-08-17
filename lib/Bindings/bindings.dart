import 'package:get/get.dart';
import 'package:webullish/Controllers/AlertsController.dart';
import 'package:webullish/Controllers/authController.dart';
import 'package:webullish/Controllers/faq_controller.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/Controllers/settingsController.dart';
import 'package:webullish/Controllers/subscribeController.dart';

class bindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => authController());
    Get.lazyPut(() => homeController());
    Get.lazyPut(() => settingsController());
    Get.lazyPut(() => subscribeController());
    Get.lazyPut(() => alertsController());
    Get.lazyPut(() => FaqController());
  }
}
