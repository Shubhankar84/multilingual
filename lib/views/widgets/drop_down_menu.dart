import 'package:flutter/material.dart';
import 'package:flyin/controller/locale_controller.dart';
import 'package:get/get.dart';

class DropDownMenuLanguage extends StatefulWidget {
  const DropDownMenuLanguage({super.key});

  @override
  State<DropDownMenuLanguage> createState() => _DropDownMenuLanguageState();
}

class _DropDownMenuLanguageState extends State<DropDownMenuLanguage> {
  final LocaleController localeController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton(
        value: localeController
            .locale.value.languageCode, // Display the selected language code
        hint: const Icon(Icons.language),
        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text("English"),
          ),
          DropdownMenuItem(
            value: 'hi',
            child: Text("Hindi"),
          ),
          DropdownMenuItem(
            value: 'mr',
            child: Text("Marathi"),
          ),
        ],
        onChanged: (String? value) {
          if (value != null) {
            localeController.changeLocale(value);
          }
        },
      );
    });
  }
}
