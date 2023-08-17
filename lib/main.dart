import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Bindings/bindings.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/Services/apiServices.dart';
import 'package:webullish/View/Screens/Auth/login.dart';

import 'package:webullish/View/bottomNavBar.dart';
import 'package:firebase_core/firebase_core.dart';

import 'View/onboarding.dart';
import 'firebase_options.dart';

const stripePublishableKey = 'pk_live_hxiKd2gWhLR0sXINKQ5lv8As004zRq5swp';
late FirebaseMessaging messaging;
int? onboard;
bool? islogin;
Widget? widget;
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  apiServices().AuthRequest(url: apiConst.logIn);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  messaging = FirebaseMessaging.instance;
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  onboard = await prefs.getInt('onBoard');
  islogin = await prefs.getBool('islogin');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(app());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: bindings(),
      home: onboard != 0
          ? const PageOnBorarding()
          : islogin == true
              ? bottomNavBar()
              : login(),
    );
  }
}
