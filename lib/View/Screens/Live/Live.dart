import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:webullish/Controllers/homeController.dart';
import 'package:webullish/View/Widgets/videoPlayer.dart';
import 'package:webullish/utils/AppColors.dart';

import '../../../Models/LiveModel.dart';

class live extends StatelessWidget {
  List<LiveModel> list = [];
  live({required this.list});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<homeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: AppColors.color1,
        body: list.isEmpty
            ? Center(
                child: Text(
                  'No Live yet',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: Get.width - 100,
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Get.to(() => OneVideoCtrl(
                                name: list[index].description.toString(),
                                url: list[index].link.toString()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(list[index].createdAt.toString()),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
