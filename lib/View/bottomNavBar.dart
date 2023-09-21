import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/AlertsController.dart';
import 'package:webullish/Controllers/faq_controller.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/Controllers/settingsController.dart';

class bottomNavBar extends StatelessWidget {
  alertsController alert = Get.put(alertsController());
  settingsController sett = Get.put(settingsController());
  FaqController faq = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<homeController>(
        init: homeController(),
        builder: (controller) => Scaffold(
              bottomNavigationBar: _bottomnav(controller: controller),
              body: controller.content,
            ));
  }
}

Widget _bottomnav({required homeController controller}) {
  return Container(
    color: const Color(0xff062029),
    height: 70,
    padding: const EdgeInsets.all(5),
    width: Get.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            controller.handleBootmNabBar(0);
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.house_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'Home',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     controller.handleBootmNabBar(1);
        //   },
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Image.asset('assets/images/Vector (1).png'),
        //       const Text(
        //         'Videos',
        //         style: TextStyle(color: Colors.grey),
        //       )
        //     ],
        //   ),
        // ),
        InkWell(
          onTap: () {
            controller.handleBootmNabBar(1);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/Vector.png',
                width: 28,
              ),
              const Text(
                'Performance',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.handleBootmNabBar(4);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/Vector (1).png',
                width: 25,
              ),
              const Text(
                'Extras',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.handleBootmNabBar(2);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/icon_profile.png',
                width: 25,
              ),
              const Text(
                'Profile',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.handleBootmNabBar(3);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/li_bell.png',
                width: 25,
              ),
              const Text(
                'Alerts',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
