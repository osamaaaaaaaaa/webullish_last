import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppHelper {
  static errorsnackbar(error) {
    return Get.snackbar('Error', error,
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  static succssessnackbar(error) {
    return Get.snackbar('Succsses', error,
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
