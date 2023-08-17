import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/authController.dart';
import 'package:webullish/View/Screens/Auth/forgetPassword.dart';
import 'package:webullish/View/Screens/Auth/register.dart';
import 'package:webullish/View/Widgets/TextFieldWidget.dart';
import 'package:webullish/View/Widgets/button.dart';
import 'package:webullish/View/bottomNavBar.dart';
import 'package:webullish/utils/AppColors.dart';
import 'package:webullish/utils/AppImages.dart';

class login extends StatelessWidget {
  var email = TextEditingController();
  var pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<authController>(
      init: authController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.color1,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Image.asset(AppImages.webullishLogo),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'LogIn today',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFieldWidget(
                  controller: email,
                  title: 'youremail@mail.com',
                  iconData: Icons.email,
                  IsPass: false),
              TextFieldWidget(
                  controller: pass,
                  title: 'password',
                  iconData: Icons.lock,
                  IsPass: true),
              InkWell(
                onTap: () {
                  Get.to(() => ForgetPassword());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  controller.signin(
                      email: email.text.trim(), password: pass.text.trim());
                },
                child: button(
                    color: AppColors.gold,
                    title: 'Login',
                    fontsize: 22,
                    fontColor: Colors.white,
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.93),
              ),
              InkWell(
                onTap: () async {
                  Get.to(() => bottomNavBar());
                },
                child: button(
                    color: AppColors.gold,
                    title: 'Login as Guest',
                    fontsize: 22,
                    fontColor: AppColors.color2,
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.93),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn’t have any account? ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => register());
                    },
                    child: Text(
                      'Sign Up here',
                      style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
