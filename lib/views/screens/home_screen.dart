import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/controller/profile_controller.dart';
import 'package:flyin/views/widgets/drop_down_menu.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int pageIdx = 0;

  // signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.flyin,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: headingColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
                onTap: () => AuthController.instance.signOut(),
                child: const Icon(Icons.logout)),
          ),
          const DropDownMenuLanguage(),
        ],
      ),
      body: Center(child: pages[pageIdx]),
      // body: Center(
      //     child: Column(
      //   children: [
      //     Text(user!.uid),
      //     Text("${user!.phoneNumber}"),
      //     // Text("${user.name}"),
      //     // Text("${user!.phoneNumber}"),
      //   ],
      // )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() => AuthController.instance.signOut()),
      //   child: Icon(Icons.login_rounded),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          if (idx == 2) {
            profileController.loadProfilePage(user!.uid);
          }
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: Colors.red,
        // unselectedItemColor: Colors.white,
        // backgroundColor: backgroundColor,
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              size: 30,
            ),
            label: AppLocalizations.of(context)!.explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            label: AppLocalizations.of(context)!.upload,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}
