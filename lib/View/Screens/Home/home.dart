import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/View/Screens/Auth/login.dart';
import 'package:webullish/View/Screens/Magazine/MagazineDetails.dart';
import 'package:webullish/View/Screens/settings/deleteAccount.dart';
import 'package:webullish/View/Widgets/Acheviment.dart';
import 'package:webullish/View/Widgets/followus.dart';
import 'package:webullish/View/Widgets/liveSocial.dart';
import 'package:webullish/View/Widgets/team.dart';
import 'package:webullish/View/Widgets/videoImage.dart';
import 'package:webullish/View/Widgets/videoPlayer.dart';
import 'package:webullish/View/Widgets/weeklyMagazine.dart';
import 'package:webullish/View/Widgets/whywebullish.dart';
import 'package:webullish/View/characters/characters.dart';
import 'package:webullish/utils/AppColors.dart';

import '../../Widgets/BreakingNotifications.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<homeController>(
      init: Get.put(homeController()),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.color1,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        controller.user == null
                            ? 'Hi'
                            : 'Hi ${controller.user?.name.toString()},',
                        style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _setting(context: context);
                      },
                      child: Icon(
                        Icons.settings,
                        color: AppColors.gold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Top Notifications',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                controller.topNotifications.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : BreakingNotifications(
                        isLoading: false,
                        data: controller.getTopNotificationsFullText(),
                        dataCount: controller.topNotifications.length,
                      ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Daily ads',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                controller.dailyAdsList.isEmpty
                    ? Center(
                        child: Text(
                        "No Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ))
                    : SizedBox(
                        height: 250,
                        // width: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.dailyAdsList.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Get.to(() => OneVideoCtrl(
                                  name: controller.dailyAdsList[index].name
                                      .toString(),
                                  url: controller.dailyAdsList[index].video
                                      .toString()));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: videoimageviw(
                                    link: controller.dailyAdsList[index].video
                                        .toString()),
                              ),
                            ),
                          ),
                        )),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Follow us on',
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
                    'Find us on all social media platforms',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                followus(),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Live training',
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
                    'Watch us closely and get all new',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                liveSocial(),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'See our analytics',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                controller.traininList.isEmpty
                    ? Center(
                        child: Text(
                        "No Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ))
                    // Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 250,
                        // width: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.traininList.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Get.to(() => OneVideoCtrl(
                                  name: controller.traininList[index].videoTitle
                                      .toString(),
                                  url: controller.traininList[index].video
                                      .toString()));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: videoimageviw(
                                    link: controller.traininList[index].video
                                        .toString()),
                              ),
                            ),
                          ),
                        )),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Weekly Magazine',
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
                    'Stay Bullish for the week ahead',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                controller.weeklyMagazineList.isEmpty
                    ? Center(
                        child: Text(
                        "No Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ))
                    //Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 165,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.weeklyMagazineList.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => MagazineDetails(
                                    image: controller
                                        .weeklyMagazineList[index].image!,
                                    body: controller.weeklyMagazineList[index]
                                        .description!));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: weeklyMagazine(
                                      image: controller
                                          .weeklyMagazineList[index].image,
                                      title: controller
                                          .weeklyMagazineList[index].name)),
                            ),
                          ),
                        )),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Recent Achievements',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: const Text(
                    'Despite the constant challenge in the stock market, we manage to pull off memorable achievements',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                controller.achevimentList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.achevimentList.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(10),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: acheviment(
                                    title: controller
                                        .achevimentList[index].description,
                                    date: controller
                                        .achevimentList[index].createdAt)),
                          ),
                        )),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Team & Advisors',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: const Text(
                    'Our team of top tier technology and investment experts are ready to work day and night to create a welcoming atmosphere and expansive access to financial services, equity analysis and maximized personal potential.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                controller.teamList.isEmpty
                    ? Center(
                        child: Text(
                        "No Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ))
                    //Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.teamList.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(10),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: teamperson(
                                    name: controller.teamList[index].name,
                                    image: controller.teamList[index].image,
                                    desc: controller
                                        .teamList[index].description)),
                          ),
                        )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'HOW ARE WE ?',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CharacterListingScreen(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Why webullish..?',
                    style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                whywebullish()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_setting({required context}) => showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(15),
          color: AppColors.color2,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  GetStorage().erase();
                  Get.offAll(() => login());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.gold,
                    ),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => deleteAcc());
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    Text(
                      'Delete Account',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
