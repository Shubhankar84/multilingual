import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/views/widgets/text_input_field.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _nameController = TextEditingController();
  AuthController _authController = Get.put(AuthController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            Text(
              AppLocalizations.of(context)!.getstarted,
              style: const TextStyle(
                  color: darkBlue, fontSize: 30, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 25,
            ),
            // const CircleAvatar(
            //   radius: 64,
            //   backgroundColor: Colors.grey,
            //   backgroundImage: NetworkImage(
            //       "https://thumbs.dreamstime.com/b/video-camera-lens-entertainment-logo-design-inspiration-fun-modern-black-illustration-camera-lens-photo-video-161279563.jpg"),
            // ),
            Stack(
              children: [
                Obx(() {
                  return CircleAvatar(
                    radius: 64,
                    backgroundImage: AuthController.instance.profilePhoto !=
                            null
                        ? FileImage(AuthController.instance.profilePhoto!)
                        : const NetworkImage(
                                "https://as2.ftcdn.net/v2/jpg/05/89/93/27/1000_F_589932782_vQAEAZhHnq1QCGu5ikwrYaQD0Mmurm0N.jpg")
                            as ImageProvider,
                    backgroundColor: Colors.grey,
                  );
                }),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      AuthController.instance.pickImage();
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _nameController,
                label: AppLocalizations.of(context)!.username,
                icon: Icons.person,
              ),
            ),
            const SizedBox(
              height: 20,
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
                onPressed: () async {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  AuthController.instance.createUser(_nameController.text,
                      AuthController.instance.profilePhoto);

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
                        AppLocalizations.of(context)!.register,
                        style: const TextStyle(color: darkBlue),
                      ),
              );
            })
          ]),
        )),
      ),
    );
  }
}
