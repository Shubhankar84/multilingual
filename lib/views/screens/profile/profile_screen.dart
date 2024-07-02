import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/profile_controller.dart';
import 'package:flyin/views/widgets/ProfileVideoCard.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.4,
                  decoration: const BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: buttonColor,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                (profileController.isLoading)
                                    ? "https://cdn1.vectorstock.com/i/1000x1000/36/00/profile-icon-vector-48303600.jpg"
                                    : profileController.user.profilePhoto,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: (profileController.isLoading)
                              ? SpinKitThreeBounce(
                                  color: Colors.white,
                                )
                              : Text(
                                  profileController.user.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        (profileController.isLoading)
                            ? SpinKitThreeBounce(
                                color: Colors.white,
                              )
                            : Text(
                                profileController.user.phoneNo,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  AppLocalizations.of(context)!.yourvideos,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                (profileController.isLoading)
                    ? SpinKitThreeBounce(
                        color: Colors.white,
                      )
                    : SizedBox(
                        width: size.width,
                        // height: size.height,
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.7),
                            itemCount: profileController.profileVideos.length,
                            itemBuilder: ((context, index) {
                              final data =
                                  profileController.profileVideos[index];
                              return ProfileVideoCard(
                                vid: data.id,
                                data: data,
                              );
                            })),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
