import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/views/screens/Auth/otp_screen.dart';
import 'package:flyin/views/widgets/drop_down_menu.dart';
import 'package:flyin/views/widgets/text_input_field.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [DropDownMenuLanguage()]),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            Text(
              AppLocalizations.of(context)!.login,
              style: TextStyle(
                  color: darkBlue, fontSize: 30, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 25,
            ),
            const CircleAvatar(
              radius: 64,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  "https://thumbs.dreamstime.com/b/video-camera-lens-entertainment-logo-design-inspiration-fun-modern-black-illustration-camera-lens-photo-video-161279563.jpg"),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                inputType: TextInputType.phone,
                controller: _phoneController,
                label: AppLocalizations.of(context)!.phonenumber,
                icon: Icons.call,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(() {
              return ElevatedButton(
                onPressed: () {
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  AuthController.instance.sendCode(_phoneController.text);
                  // setState(() {
                  //   isLoading = false;
                  // });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.88, 50),
                ),
                child: (_authController.isLoading)
                    ? const SpinKitThreeBounce(
                        color: darkBlue,
                        size: 20,
                      )
                    : Text(
                        AppLocalizations.of(context)!.getotp,
                        style: TextStyle(color: darkBlue),
                      ),
              );
            })
          ]),
        )),
      ),
    );
  }
}
