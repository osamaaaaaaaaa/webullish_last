import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/View/Screens/Auth/login.dart';

import '../Models/UserModel.dart';
import '../Services/apiServices.dart';
import '../View/Widgets/button.dart';
import '../View/bottomNavBar.dart';
import '../utils/AppHelper.dart';

class settingsController extends GetxController {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  User? user;
  settingsController() {
    getUserProfile();
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
        name.text = user!.name.toString();
        email.text = user!.email.toString();

        update();
      });
    } catch (e) {
      print(e);
    }
  }

  updateProfilr({required name, required email, required password}) async {
    if (user?.name == 'Guest' || user == null) {
      AppHelper.errorsnackbar('Not Allowed');
      return;
    }
    User model = User(
      name: name,
      email: email,
      password: password,
    );
    try {
      await apiServices()
          .postRequestMap(url: 'api/updateProfile', body: model.toJson())
          .then((value) {
        if (value.isNotEmpty && value['error'] != null) {
          AppHelper.errorsnackbar("Update :${value['error']}");

          return;
        }

        Get.offAll(() => bottomNavBar());

        update();
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  deleteacc() {
    Get.defaultDialog(
        title: 'are you sure ? ',
        content: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: button(
                      color: Colors.green,
                      title: "Back",
                      height: 30,
                      fontColor: Colors.white,
                      fontsize: 16,
                      width: 120),
                ),
                InkWell(
                  onTap: () async {
                    _deleteAcc();
                  },
                  child: button(
                      color: Colors.red,
                      title: "Confirm",
                      height: 30,
                      fontsize: 16,
                      width: 120,
                      fontColor: Colors.white),
                ),
              ],
            )
          ],
        ));
  }

  _deleteAcc() async {
    var prefs = await SharedPreferences.getInstance();

    await apiServices()
        .postRequestMap(url: 'api/delete', body: null)
        .then((value) => {
              if (value['error'] == null)
                {
                  if (value['status'] == true)
                    {
                      AppHelper.errorsnackbar(value['message']),
                      prefs.clear(),
                      Get.offAll(login()),
                    }
                }
            });
  }
}
