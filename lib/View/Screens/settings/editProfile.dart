import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/settingsController.dart';
import 'package:webullish/View/Widgets/TopAppBar.dart';
import 'package:webullish/utils/AppColors.dart';

import '../../Widgets/TextFieldWidget.dart';
import '../../Widgets/button.dart';

class editProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<settingsController>(
      init: settingsController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.color1,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TopAppBar(title: 'Edit Profile'),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Edit Your Information',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFieldWidget(
                  controller: controller.name,
                  title: 'your name',
                  iconData: Icons.person,
                  IsPass: false),
              TextFieldWidget(
                  controller: controller.email,
                  title: 'youremail@mail.com',
                  iconData: Icons.email,
                  IsPass: false),
              TextFieldWidget(
                  controller: controller.password,
                  title: 'password',
                  iconData: Icons.lock,
                  IsPass: true),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  if (controller.name.text.isEmpty ||
                      controller.email.text.isEmpty ||
                      controller.password.text.isEmpty) {
                    return;
                  }
                  controller.updateProfilr(
                      name: controller.name.text,
                      email: controller.email.text.trim(),
                      password: controller.password.text.trim());
                },
                child: button(
                    color: AppColors.gold,
                    title: 'Update information',
                    fontsize: 20,
                    fontColor: Colors.white,
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.93),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
