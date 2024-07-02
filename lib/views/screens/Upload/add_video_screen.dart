// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/get_locatoin_controller.dart';
import 'package:flyin/views/screens/Upload/confirm_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      // await GetLocationController.instance.checkPermission();
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        return ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        );
      })));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(AppLocalizations.of(context)!.gallery),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(AppLocalizations.of(context)!.camera),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(AppLocalizations.of(context)!.cancel),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: InkWell(
        onTap: () async {
          await GetLocationController.instance.checkPermission();
          showOptionsDialog(context);
        },
        child: Container(
          width: size.width * 0.8,
          height: 400,
          // decoration: BoxDecoration(
          //   color: buttonColor,
          // ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    width: size.width * 0.7,
                    height: 300,
                    image: const NetworkImage(
                        'https://img.freepik.com/premium-vector/file-management-administration-data-filing-concept-folder-gallery-records-database-flat-illustration-vector-template_128772-1923.jpg')),
                Text(
                  AppLocalizations.of(context)!.addvideo,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
