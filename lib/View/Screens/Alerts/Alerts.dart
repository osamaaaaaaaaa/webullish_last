import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/AlertsController.dart';
import 'package:webullish/View/Screens/Alerts/AlertsDetails.dart';
import 'package:webullish/View/Screens/subscriptions/subscribe.dart';
import 'package:webullish/View/Widgets/TopAppBar.dart';
import 'package:webullish/View/Widgets/videoImage.dart';
import 'package:webullish/utils/AppColors.dart';

class alerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<alertsController>(
      init: alertsController(),
      builder: (controller) => Scaffold(
          backgroundColor: AppColors.color1,
          body: controller.loading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.IssubLoding
                  ? Center(
                      child: LinearProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : controller.IsSubscribe
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              TopAppBar(title: "Alerts"),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView.builder(
                                  itemCount: controller.alertsList.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Get.to(() => alertsDetails(
                                          image: controller
                                              .alertsList[index].image,
                                          video: controller
                                              .alertsList[index].video,
                                          body: controller
                                              .alertsList[index].description,
                                          senttime: controller
                                              .alertsList[index].sendTime
                                              .toString(),
                                          title: controller
                                              .alertsList[index].name
                                              .toString()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: controller
                                                          .alertsList[index]
                                                          .image !=
                                                      null
                                                  ? Image.network(
                                                      controller
                                                          .alertsList[index]
                                                          .image
                                                          .toString(),
                                                      width: Get.width * 0.2,
                                                    )
                                                  : videoimageviww2(
                                                      link: controller
                                                          .alertsList[index]
                                                          .video!)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                controller
                                                    .alertsList[index].name
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                controller
                                                    .alertsList[index].sendTime
                                                    .toString(),
                                                style: TextStyle(
                                                    color: AppColors.gold,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        )
                      : subscribe()),
    );
  }
}
