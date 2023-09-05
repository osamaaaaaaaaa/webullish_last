import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/Models/CountriesModel.dart';
import 'package:webullish/Models/UserModel.dart';
import 'package:webullish/Services/StorageKey.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/View/Screens/Auth/entercode.dart';
import 'package:webullish/View/Screens/Auth/login.dart';
import 'package:webullish/View/bottomNavBar.dart';

import '../Services/apiServices.dart';
import '../utils/AppHelper.dart';

class authController extends GetxController {
  GetStorage _box = GetStorage();
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

    try {
      await apiServices()
          .authRequest(
        url: apiConst.logIn,
        credintial: model.toJson(),
      )
          .then((value) async {
        if (value.isNotEmpty && value['error'] != null) {
          AppHelper.errorsnackbar("signin:${value['error']}");

          return;
        }
        _box.write(StorageKey.credintal, {
          "email": email.toString().trim(),
          "password": password.toString().trim()
        });

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
          .authRequest(
        url: apiConst.signUp,
        credintial: model.toJson(),
      )
          .then((value) async {
        if (value.isNotEmpty && value['error'] != null) {
          AppHelper.errorsnackbar("signup:${value['error']}");

          return;
        }
        _box.write(StorageKey.credintal, {
          "email": email.toString().trim(),
          "password": password.toString().trim()
        });
        _box.write(StorageKey.userdata, value);
        _box.write(StorageKey.token, value['access_token']);
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
      await apiServices().getRequestMap(url: apiConst.countries).then((value) {
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

  int? code;
  forgetPass(email) async {
    try {
      await apiServices().postRequestMap(
          url: 'api/password/email', body: {'email': email}).then((value) {
        print(value);
        if (value['error']['message'].toString() ==
            'User successfully sent code check it') {
          AppHelper.succssessnackbar(value['error']['message'].toString());
          code = value['code'];
          Get.to(() => entercode());
          return;
        }
        AppHelper.errorsnackbar(value['message'].toString());
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  resetPassword({required code, required pass, required repass}) async {
    await apiServices().postRequestMap(url: 'api/password/reset', body: {
      'code': code,
      'password': pass,
      'password_confirmation': repass
    }).then((value) {
      print(value);
      if (value['message'] == 'Password reset successfully') {
        AppHelper.succssessnackbar("${value['message']}");
        Get.to(() => login());
        return;
      }
      code = value['code'];
      AppHelper.errorsnackbar("${value['message']}");
    });
    update();
  }
}
