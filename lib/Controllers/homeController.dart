import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Models/AchevimentModel.dart';
import 'package:webullish/Models/DailyAdsModel.dart';
import 'package:webullish/Models/MagzineModel.dart';
import 'package:webullish/Models/PerformanceModel.dart';
import 'package:webullish/Models/TeamModel.dart';
import 'package:webullish/Models/TopNotificationModel.dart';
import 'package:webullish/Models/TrainModel.dart';
import 'package:webullish/Models/UserModel.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/Services/apiServices.dart';
import 'package:webullish/View/Screens/Alerts/Alerts.dart';
import 'package:webullish/View/Screens/Auth/register.dart';
import 'package:webullish/View/Screens/Home/home.dart';
import 'package:webullish/View/Screens/settings/editProfile.dart';
import 'package:webullish/faq_screen.dart';

import '../Models/FollowUp.dart';
import '../Models/LiveModel.dart';
import '../View/Screens/performance/performance.dart';
import '../utils/AppHelper.dart';

class homeController extends GetxController {
  Widget content = home();
  List<TopNotificationModel> topNotifications = [];
  List<DailyAdsModel> dailyAdsList = [];
  List<MagazineModel> weeklyMagazineList = [];
  List<AcheviementModel> achevimentList = [];
  List<TeamModel> teamList = [];
  List<PerformanceModel> performanceList = [];
  List<LiveModel> facebookLive = [];
  List<LiveModel> youtubelive = [];
  List<LiveModel> instalive = [];
  List<LiveModel> twitterlive = [];

  User? user;
  homeController() {
    getTopNoti();
    getDailyAds();
    gettrainingAds();
    getWeeklyMagazine();
    getAcheviments();
    //   getTeams();
    getPerformance();
    getUserProfile();
    getInstaLive();
    gettwitterLive();
    getyoutubeLive();
    getfaceLive();
    getSocialPages();
  }
  getUserProfile() async {
    try {
      await apiServices().getRequestMap(url: apiConst.userByID).then((value) {
        if (value.isNotEmpty && value['error'] != null) {
          //      AppHelper.errorsnackbar("user:${value['error']}");

          return;
        }
        user = User.fromJson(value['user']);

        update();
      });
    } catch (e) {
      print(e);
    }
  }

  handleBootmNabBar(i) {
    switch (i) {
      case 0:
        if (content == home()) {
          return;
        }
        content = home();
        update();

        break;

      case 1:
        if (content == performance()) {
          return;
        }
        content = performance();
        update();

        break;
      case 2:
        if (content == editProfile()) {
          return;
        }
        if (user?.name == 'Guest') {
          Get.to(() => register());
          return;
        }

        content = editProfile();
        update();

        break;
      case 3:
        if (content == alerts()) {
          return;
        }
        content = alerts();
        update();

        break;
      case 4:
        if (content == FaqScreen()) {
          return;
        }
        content = FaqScreen();
        update();

        break;
      default:
    }
  }

  getDailyAds() async {
    dailyAdsList.clear();
    await apiServices().getRequestList(url: apiConst.dailyAds).then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Daily Ads:${value[0]['error']}");

        return;
      }

      for (var e in value) {
        dailyAdsList.add(DailyAdsModel.fromJson(e));

        update();
      }
    });
    update();
  }

  List<trainingModel> traininList = [];
  gettrainingAds() async {
    traininList.clear();
    await apiServices()
        .getRequestList(url: 'api/training_video/show_all')
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Daily Ads:${value[0]['error']}");

        return;
      }

      for (var e in value) {
        traininList.add(trainingModel.fromJson(e));

        update();
      }
    });
    update();
  }

  getWeeklyMagazine() async {
    weeklyMagazineList.clear();
    await apiServices()
        .getRequestList(url: apiConst.weeklyMagazine)
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("weekly Magazine:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        weeklyMagazineList.add(MagazineModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  getAcheviments() async {
    achevimentList.clear();
    await apiServices().getRequestList(url: apiConst.achievment).then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Achievment :${value[0]['error']}");

        return;
      }
      for (var e in value) {
        achevimentList.add(AcheviementModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  getTeams() async {
    teamList.clear();
    await apiServices().getRequestList(url: apiConst.teams).then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Teams:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        teamList.add(TeamModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  getPerformance() async {
    try {
      performanceList.clear();
      await apiServices()
          .getRequestMap(url: apiConst.performance)
          .then((value) {
        if (value.isNotEmpty && value['error'] != null) {
          //    AppHelper.errorsnackbar("Performance:${value['error']}");

          return;
        }

        for (var e in value['data']) {
          performanceList.add(PerformanceModel.fromJson(e));

          update();
        }
        update();
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  double right = 0;
  double field = 0;
  double precent = 0;
  calcPerformancePercentage(i) {
    precent = 0;
    right = 0;
    update();
    for (var element in performanceList[i].performance!) {
      if (element.reached_min! < (int.tryParse(element.target!))!) {
        right++;
      }
      precent = right / performanceList[i].performance!.length;
      update();
    }
  }

  getInstaLive() async {
    instalive.clear();
    await apiServices()
        .getRequestList(url: 'api/liveinstagram/show_all')
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Teams:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        instalive.add(LiveModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  getfaceLive() async {
    facebookLive.clear();
    await apiServices()
        .getRequestList(url: 'api/livefacebook/show_all')
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Teams:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        facebookLive.add(LiveModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  gettwitterLive() async {
    twitterlive.clear();
    await apiServices()
        .getRequestList(url: 'api/livetwitter/show_all')
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Teams:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        twitterlive.add(LiveModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  getyoutubeLive() async {
    youtubelive.clear();
    await apiServices()
        .getRequestList(url: 'api/liveyoutube/show_all')
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Teams:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        youtubelive.add(LiveModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  getTopNoti() async {
    youtubelive.clear();
    await apiServices()
        .getRequestList(url: 'api/top_notification/show_all')
        .then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("top:${value}");

        return;
      }
      for (var e in value) {
        topNotifications.add(TopNotificationModel.fromJson(e));

        update();
      }
      update();
    });
    getTopNotificationsFullText();
    update();
  }

  List<FollowUpModel> socilaList = [];
  getSocialPages() async {
    socilaList.clear();
    await apiServices().getRequestList(url: apiConst.follow).then((value) {
      if (value.isNotEmpty && value[0]['error'] != null) {
        //  AppHelper.errorsnackbar("Teams:${value[0]['error']}");

        return;
      }
      for (var e in value) {
        socilaList.add(FollowUpModel.fromJson(e));

        update();
      }
      update();
    });
    update();
  }

  String getTopNotificationsFullText() {
    String fullText = '';

    topNotifications.forEach((element) {
      if (element != null) {
        fullText += element.name! +
            '  -|-  ' +
            element.description.toString() +
            '    ⚪  ️  ';
      }
    });

    return fullText;
  }
}
