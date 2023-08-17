import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/View/Screens/performance/performanceDetails.dart';
import 'package:webullish/View/Widgets/TopAppBar.dart';
import 'package:webullish/utils/AppColors.dart';

import '../../Widgets/button.dart';

class performance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<homeController>(
        init: homeController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.color1,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TopAppBar(title: 'Webullish Performance'),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      'Monthly Performance',
                      style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: const Text(
                      'We have made it easier than ever to access our many invaluable reports! check them all out here, broken down into monthly categories.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 310,
                    child: ListView.builder(
                      itemCount: controller.performanceList.length,
                      itemBuilder: (context, index) => _widget(
                          controller.performanceList[index].month,
                          index,
                          controller),
                    ),
                  )
                ],
              ),
            ));
  }
}

Widget _widget(title, i, homeController controller) => Center(
      child: Container(
        margin: const EdgeInsets.all(15),
        alignment: Alignment.center,
        height: 250,
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff2A2936)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Performance ${title[0]}${title[1]}${title[2]}',
              style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                'Here you will find all of our analyzes for this month',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            InkWell(
              onTap: () {
                controller.calcPerformancePercentage(i);
                Get.to(() => performancedetails(
                      i: i,
                      month: title,
                    ));
              },
              child: button(
                  color: AppColors.gold,
                  title: 'SEE RESULTS',
                  fontsize: 20,
                  fontColor: Colors.white,
                  height: 50,
                  width: 230),
            ),
          ],
        ),
      ),
    );
