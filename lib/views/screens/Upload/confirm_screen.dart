import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/get_locatoin_controller.dart';
import 'package:flyin/controller/upload_vide_controller.dart';
import 'package:flyin/views/screens/Upload/current_location.dart';
import 'package:flyin/views/widgets/text_input_field.dart';
import 'package:get/get.dart';
// import 'package:tiktok/controller/upload_video_controller.dart';
// import 'package:tiktok/views/widgets/textInputField.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen({
    super.key,
    required this.videoFile,
    required this.videoPath,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;

  late String category;
  bool scanning = false;
  bool isLoading = false;

  // TextEditingController songController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextInputField(
                        controller: titleController,
                        icon: Icons.title,
                        label: AppLocalizations.of(context)!.title,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextInputField(
                        controller: captionController,
                        icon: Icons.closed_caption,
                        label: AppLocalizations.of(context)!.caption,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all()),
                      // child: Text(GetLocationController.instance.address),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 8,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.location_pin),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: scanning
                                    ? SpinKitThreeBounce(
                                        color: darkBlue,
                                        size: 20,
                                      )
                                    : Text(
                                        GetLocationController.instance.address,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                // child: TextField(
                                //   enabled: false,
                                //   decoration: InputDecoration(
                                //     // suffixIcon: Icon(Icons.refresh),
                                //     prefixIcon: Icon(Icons.location_pin),
                                //     labelStyle: const TextStyle(
                                //         fontSize: 30, color: Colors.red),
                                //     // enabledBorder: OutlineInputBorder(
                                //     //   borderRadius: BorderRadius.circular(5),
                                //     //   borderSide: const BorderSide(
                                //     //     color: Colors.black,
                                //     //   ),
                                //     // ),
                                //     // focusedBorder: OutlineInputBorder(
                                //     //   borderRadius: BorderRadius.circular(5),
                                //     //   borderSide: const BorderSide(
                                //     //     color: Colors.black,
                                //     //   ),
                                //     // ),
                                //   ),
                                //   controller: TextEditingController(
                                //     text: GetLocationController.instance.address,
                                //   ),
                                // ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () async {
                                    setState(() {
                                      scanning = true;
                                    });
                                    await GetLocationController.instance
                                        .checkPermission();
                                    setState(() {
                                      scanning = false;
                                    });
                                  },
                                  child: const Icon(Icons.refresh_sharp)),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownMenu(
                        onSelected: (value) {
                          if (value != null) {
                            setState(() {
                              category = value;
                            });
                          }
                        },
                        // enableSearch: true,
                        // enableFilter: true,
                        label: Text(
                            AppLocalizations.of(context)!.selectcategory),
                        width: MediaQuery.of(context).size.width - 20,
                        dropdownMenuEntries: <DropdownMenuEntry>[
                          DropdownMenuEntry(
                              value: 'Entertainment',
                              label:
                                  AppLocalizations.of(context)!.entertainment),
                          DropdownMenuEntry(
                              value: 'Education',
                              label: AppLocalizations.of(context)!.education),
                          DropdownMenuEntry(
                              value: 'Lifestyle',
                              label: AppLocalizations.of(context)!.lifestyle),
                          DropdownMenuEntry(
                              value: 'Travel',
                              label: AppLocalizations.of(context)!.travel),
                          DropdownMenuEntry(
                              value: 'Gaming',
                              label: AppLocalizations.of(context)!.gaming),
                          DropdownMenuEntry(
                              value: 'Sports',
                              label: AppLocalizations.of(context)!.sports),
                          DropdownMenuEntry(
                              value: 'Music',
                              label: AppLocalizations.of(context)!.music),
                          DropdownMenuEntry(
                              value: 'Vlogs',
                              label: AppLocalizations.of(context)!.vlogs),
                          DropdownMenuEntry(
                              value: 'Technology',
                              label: AppLocalizations.of(context)!.technology),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.88, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await uploadVideoController.uploadVideo(
                            titleController.text,
                            captionController.text,
                            GetLocationController.instance.address,
                            category,
                            widget.videoPath,
                          );

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: (isLoading)
                            ? const SpinKitThreeBounce(
                                color: darkBlue,
                                size: 20,
                              )
                            : Text(
                                AppLocalizations.of(context)!.share,
                                style: TextStyle(fontSize: 20, color: darkBlue),
                              )),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
