import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/views/screens/Auth/wrapper.dart';
import 'package:flyin/views/widgets/drop_down_menu.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  final String vid;
  final String phoneNo;
  const OtpScreen({
    super.key,
    required this.phoneNo,
    required this.vid,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String code = "";
  bool isLoading = false;

  // signIn() async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: widget.vid,
  //     smsCode: code,
  //   );

  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithCredential(credential)
  //         .then((value) => Get.offAll(Wrapper()));
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar('Error otp', e.code);
  //   } catch (e) {
  //     Get.snackbar('Error otp', e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [DropDownMenuLanguage()],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Image(
            image: NetworkImage(
                "https://thumbs.dreamstime.com/b/otp-one-time-password-step-authentication-data-protection-internet-security-concept-otp-one-time-password-step-authentication-data-254434939.jpg"),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!.otpverification,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "${AppLocalizations.of(context)!.enterotpsent} \n +91 ${widget.phoneNo}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Pinput(
              length: 6,
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await AuthController.instance.signIn(
                    widget.vid,
                    code,
                  );
                  setState(() {
                    isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                child: (isLoading)
                    ? const SpinKitThreeBounce(
                        color: darkBlue,
                        size: 20,
                      )
                    : Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          AppLocalizations.of(context)!.verfiyproceed,
                          style: TextStyle(
                            fontSize: 18,
                            color: darkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
          )
        ],
      )),
    );
  }
}
