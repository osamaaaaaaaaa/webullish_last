import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webullish/utils/AppColors.dart';

Widget TopAppBar({
  required title,
}) {
  return Container(
    width: Get.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(
              color: AppColors.gold, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 20,
        )
      ],
    ),
  );
}
