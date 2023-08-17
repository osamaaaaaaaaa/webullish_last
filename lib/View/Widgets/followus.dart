import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/utils/AppHelper.dart';
import 'package:webullish/utils/AppImages.dart';

class followus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<homeController>(
      init: homeController(),
      builder: (controller) => Container(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
                onTap: () {
                  _launchUrl(controller.socilaList[0].facebook.toString());
                },
                child: _widget(
                    padding: 0,
                    image: AppImages.facebook,
                    title: 'Facebook',
                    Width: 80)),
            InkWell(
                onTap: () {
                  _launchUrl(controller.socilaList[0].twitter.toString());
                },
                child: _widget(
                    padding: 0,
                    image: AppImages.twitter,
                    title: 'Twitter',
                    Width: 80)),
            InkWell(
                onTap: () {
                  _launchUrl(controller.socilaList[0].youtube.toString());
                },
                child: _widget(
                    padding: 0,
                    image: AppImages.youtube,
                    title: 'Youtube',
                    Width: 80)),
            InkWell(
                onTap: () {
                  _launchUrl(controller.socilaList[0].instagram.toString());
                },
                child: _widget(
                    padding: 50,
                    image: AppImages.instgram,
                    title: 'Insatgram',
                    Width: 100)),
          ],
        ),
      ),
    );
  }
}

Widget _widget({
  required image,
  required title,
  required double padding,
  required double Width,
}) {
  return Container(
    margin: EdgeInsets.all(10),
    // padding: EdgeInsets.only(bottom: padding),
    child: Column(
      children: [
        Image.asset(
          image,
          height: Width,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

Future<void> _launchUrl(url) async {
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    AppHelper.errorsnackbar(e.toString());
  }
}
