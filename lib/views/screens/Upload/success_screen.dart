import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/views/screens/Auth/wrapper.dart';
import 'package:flyin/views/screens/Upload/add_video_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class VideUploadSuccess extends StatelessWidget {
  const VideUploadSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              AppLocalizations.of(context)!.uploadsuccess,
              style: TextStyle(
                  color: darkBlue, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Image(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 250,
              fit: BoxFit.cover,
              image: const AssetImage('assets/images/happyR.png'),
            ),
            Text(
              AppLocalizations.of(context)!.filesuccess,
              style: TextStyle(
                fontSize: 20,
                color: darkBlue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: buttonColor,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Wrapper()),
                  (route) => false,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.home,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const AddVideoScreen();
                    }),
                  );
                },
                child:  Text(
                  AppLocalizations.of(context)!.uploadmore,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
