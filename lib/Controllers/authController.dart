import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/Models/CountriesModel.dart';
import 'package:webullish/Models/UserModel.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/View/Screens/Auth/entercode.dart';
import 'package:webullish/View/bottomNavBar.dart';

import '../Services/apiServices.dart';
import '../utils/AppHelper.dart';

class authController extends GetxController {
  List<CountriesModel> countriesList = [];
  List<Cities> citiesList = [];
  String country = 'Select Country';
  String city = 'Select City';
  int? countryId;
  int? cityId;
  authController() {
    getCountries();
  }
  signin({required email, required password}) async {
    _loading();
    User model = User(email: email, password: password);
    var prefs = await SharedPreferences.getInstance();

    try {
      await apiServices()
          .postRequestMap(url: apiConst.logIn, body: model.toJson())
          .then((value) async {
        if (value.isNotEmpty && value['error'] != null) {
          AppHelper.errorsnackbar("signin:${value['error']}");

          return;
        }
        await prefs.setString('email', email.toString());
        await prefs.setString('pass', email.toString());
        await prefs.setBool('islogin', true);

        saveData(token: value['access_token']);
        homeController().handleBootmNabBar(0);

        Get.offAll(() => bottomNavBar());

        update();
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  signup({required name, required email, required password}) async {
    var prefs = await SharedPreferences.getInstance();
    _loading();
    User model = User(
        name: name,
        email: email,
        password: password,
        city: city.toString(),
        country: country,
        cityId: cityId,
        countryId: countryId);
    try {
      await apiServices()
          .postRequestMap(url: apiConst.signUp, body: model.toJson())
          .then((value) async {
        if (value.isNotEmpty && value['error'] != null) {
          AppHelper.errorsnackbar("signup:${value['error']}");

          return;
        }
        await prefs.setString('email', email.toString());
        await prefs.setString('pass', email.toString());
        await prefs.setBool('islogin', true);
        saveData(token: value['access_token']);
        homeController().handleBootmNabBar(0);
        Get.offAll(() => bottomNavBar());

        update();
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  getCountries() async {
    try {
      countriesList.clear();
      await apiServices().getRequestMap(apiConst.countries).then((value) {
        if (value.isNotEmpty && value['error'] != null) {
          //    AppHelper.errorsnackbar("Countries:${value['error']}");

          return;
        }

        for (var e in value['token_type']) {
          countriesList.add(CountriesModel.fromJson(e));

          update();
        }

        update();
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  _loading() {
    Get.defaultDialog(
        title: 'Loading',
        content: Center(
          child: CircularProgressIndicator(),
        ));
  }

  saveData({required token}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('userjwt', token.toString());
  }

  int? code;
  forgetPass(email) async {
    await apiServices().postRequestMap(
        url: 'api/password/email', body: {'email': email}).then((value) {
      print(value);
      if (value.isNotEmpty && value['error'] != null) {
        //    AppHelper.errorsnackbar("Countries:${value['error']}");

        return;
      }
      code = value['code'];
      Get.to(() => entercode());
    });
    update();
  }

  resetPassword({required code, required pass, required repass}) async {
    await apiServices().postRequestMap(url: 'api/password/reset', body: {
      'code': code,
      'password': pass,
      'password_confirmation': repass
    }).then((value) {
      if (value.isNotEmpty && value['error'] != null) {
        //    AppHelper.errorsnackbar("Countries:${value['error']}");

        return;
      }
      code = value['code'];
      AppHelper.errorsnackbar("${value['message']}");
    });
    update();
  }
}
