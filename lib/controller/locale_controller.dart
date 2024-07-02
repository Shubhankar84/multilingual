import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocaleController extends GetxController {
  Rx<Locale> locale = Rx<Locale>(const Locale('en'));

  void changeLocale(String langCode) {
    var newLocale = Locale(langCode);
    Get.updateLocale(newLocale);
    locale.value = newLocale;
  }
}
