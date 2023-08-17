import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/View/Screens/Live/Live.dart';

import '../../utils/AppImages.dart';

class liveSocial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<homeController>(
      init: homeController(),
      builder: (controller) => Container(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => live(
                      list: controller.facebookLive,
                    ));
              },
              child: _widget(
                image: AppImages.livefacebook,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => live(
                      list: controller.instalive,
                    ));
              },
              child: _widget(
                image: AppImages.liveinsta,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => live(
                      list: controller.twitterlive,
                    ));
              },
              child: _widget(
                image: AppImages.livetwitter,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => live(
                      list: controller.youtubelive,
                    ));
              },
              child: _widget(
                image: AppImages.liveyoutube,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _widget({required image}) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      children: [
        Image.asset(
          image,
        ),
      ],
    ),
  );
}
