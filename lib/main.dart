import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/controller/get_locatoin_controller.dart';
import 'package:flyin/controller/locale_controller.dart';
import 'package:flyin/controller/video_controller.dart';
import 'package:flyin/views/screens/Auth/login_screen.dart';
import 'package:flyin/views/screens/Auth/otp_screen.dart';
import 'package:flyin/views/screens/Auth/signUp.dart';
import 'package:flyin/views/screens/Auth/wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(GetLocationController());
    Get.put(LocaleController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Get.find<LocaleController>().locale.value,
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
      ],
      home: Wrapper(),
    );
  }
}
