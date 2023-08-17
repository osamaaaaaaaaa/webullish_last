import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Models/AlertModel.dart';
import 'package:webullish/Models/SubscribeModel.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/Services/apiServices.dart';

import '../Models/UserModel.dart';
import '../utils/AppHelper.dart';

class alertsController extends GetxController {
  List<AlertModel> alertsList = [];
  alertsController() {
    isSubscribe();

    getAlerts();

    // getUserProfile();
  }
  User? user;
  bool loading = false;
  getAlerts() async {
    loading = true;
    alertsList.clear();
    await apiServices().getRequestMap(apiConst.getNotification).then((value) {
      if (value.isNotEmpty && value['error'] != null) {
        //   AppHelper.errorsnackbar("alerts :${value['error']}");

        return;
      }

      for (var e in value['data']) {
        alertsList.add(AlertModel.fromJson(e));

        update();
      }

      update();
    });
    loading = false;
    update();
  }

  getUserProfile() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getString('userjwt') == null) {
      return;
    }
    try {
      await apiServices()
          .getprofile(apiConst.userByID, pref.getString('userjwt'))
          .then((value) {
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

  SubscribeModel? subscribeModel;
  bool IsSubscribe = false;
  isSubscribe() async {
    var pref = await SharedPreferences.getInstance();
    var jwt = await pref.getString('userjwt');
    print(jwt);
    if (jwt == null) {
      return;
    }
    try {
      await apiServices().postProfile(apiConst.getSubscribe, jwt).then((value) {
        if (value.isNotEmpty && value['error'] != null) {
          //AppHelper.errorsnackbar("user:${value['error']}");
          print("user:${value['error']}");

          return;
        }
        if (value['subscriptions'] == null) {
          return;
        }
        print(value);
        subscribeModel = SubscribeModel.fromJson(
            value['subscriptions'][value['subscriptions'].length - 1]);
        // print(subscribeModel);
        IsSubscribe =
            DateTime.tryParse(subscribeModel!.endsAt!)!.isAfter(DateTime.now());
        if (IsSubscribe == false) {
          FirebaseMessaging.instance.unsubscribeFromTopic('topic');
        }
        // print(IsSubscribe);
        update();
      });
    } catch (e) {
      print(e);
    }
  }

//   UrlType getUrlType(String url) {
//     Uri uri = Uri.parse(url);
//     String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
//     if (typeString == "jpg") {
//       return UrlType.IMAGE;
//     }
//     if (typeString == "mp4") {
//       return UrlType.VIDEO;
//     } else {
//       return UrlType.UNKNOWN;
//     }
//   }
}

// enum UrlType { IMAGE, VIDEO, UNKNOWN }
