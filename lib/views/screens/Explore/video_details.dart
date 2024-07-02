import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/controller/profile_controller.dart';
import 'package:flyin/controller/video_controller.dart';
import 'package:flyin/models/video.dart';
import 'package:flyin/views/screens/profile/profile_screen.dart';
import 'package:flyin/views/widgets/profile_logo.dart';
import 'package:flyin/views/widgets/search_box.dart';
import 'package:flyin/views/widgets/video_player_item.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VideoDetails extends StatelessWidget {
  final Video data;
  // final String id;
  // final int index2;
  VideoDetails({super.key, required this.data});

  final VideoController videoController = Get.put(VideoController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.videodetails,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: darkBlue,
          ),
        ),
      ),
      body: Column(
        children: [
          // SearchBox(),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  final temp = videoController.videoList[index];

                  return Column(
                    children: [
                      VideoPlayerItem(
                        videoUrl: data.videoUrl,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  final likes = videoController.videoList
                                      .firstWhere(
                                          (video) => video.id == data.id)
                                      .likes;
                                  // videoController.videoList[index].likes;
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          videoController.likeVideo(data.id);
                                        },
                                        child: likes.contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            ? const Icon(Icons.thumb_up)
                                            : const Icon(
                                                Icons.thumb_up_alt_outlined),
                                      ),
                                      Text(
                                        likes.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  );
                                }),
                                Obx(() {
                                  final dislikes = videoController.videoList
                                      .firstWhere(
                                          (video) => video.id == data.id)
                                      .dislikes;
                                  // videoController.videoList[index].dislikes;
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          videoController.dislikeVideo(data.id);
                                        },
                                        child: dislikes.contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            ? const Icon(Icons.thumb_down)
                                            : const Icon(
                                                Icons.thumb_down_alt_outlined),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        dislikes.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  );
                                }),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Icon(Icons.ios_share_rounded),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.share,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  final views = videoController.videoList
                                      .firstWhere(
                                          (video) => video.id == data.id)
                                      .views;
                                  // videoController.videoList[index].views;
                                  return Text(
                                    '$views ${AppLocalizations.of(context)!.views}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  );
                                }),
                                Text(
                                  '2 ${AppLocalizations.of(context)!.daysago}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  videoController.getVideoCategory(
                                      context, data.category),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ProfileLogo(
                                      url: data.profilePhoto,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    bool value = await profileController
                                        .fetchProfile(data.uid);
                                    if (value) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) {
                                        return ProfileScreen();
                                      })));
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.viewall,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                })),
          )

          // Expanded(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: Column(
          //       children: [
          //         VideoPlayerItem(
          //           videoUrl: data.videoUrl,
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         Text(
          //           data.title,
          //           style: const TextStyle(
          //             fontSize: 30,
          //             fontWeight: FontWeight.bold,
          //             color: darkBlue,
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //           child: Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Obx(() {
          //                     return Row(
          //                       children: [
          //                         InkWell(
          //                           onTap: () {
          //                             videoController.likeVideo(data.id);
          //                           },
          //                           child: videoController.likeVideo(data.id)
          //                               ? Icon(Icons.thumb_up,
          //                                   color: Colors.blue)
          //                               : Icon(Icons.thumb_up_alt_outlined),
          //                         ),
          //                         Text(
          //                           data.likes.length.toString(),
          //                           style: TextStyle(
          //                               color: Colors.black, fontSize: 15),
          //                         ),
          //                       ],
          //                     );
          //                   }),
          //                   Row(
          //                     children: [
          //                       Obx(() {
          //                         return InkWell(
          //                           onTap: () {
          //                             videoController.dislikeVideo(data.id);
          //                           },
          //                           child: videoController.dislikeVideo(data.id)
          //                               ? Icon(Icons.thumb_down,
          //                                   color: Colors.red)
          //                               : Icon(Icons.thumb_down_alt_outlined),
          //                         );
          //                       }),
          //                       const SizedBox(
          //                         width: 5,
          //                       ),
          //                       Text(
          //                         data.dislikes.length.toString(),
          //                         style: TextStyle(
          //                             color: Colors.black, fontSize: 15),
          //                       ),
          //                     ],
          //                   ),
          //                   const Row(
          //                     children: [
          //                       InkWell(
          //                         child: Icon(Icons.ios_share_rounded),
          //                       ),
          //                       const SizedBox(
          //                         width: 5,
          //                       ),
          //                       const Text(
          //                         "Share",
          //                         style: TextStyle(
          //                             color: Colors.black, fontSize: 15),
          //                       )
          //                     ],
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     '${data.views} views',
          //                     style: TextStyle(
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                   Text(
          //                     '2 Days ago',
          //                     style: TextStyle(
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                   Text(
          //                     data.category,
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 15,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Row(
          //                     children: [
          //                       ProfileLogo(
          //                         url: data.profilePhoto,
          //                       ),
          //                       const SizedBox(
          //                         width: 5,
          //                       ),
          //                       Text(
          //                         data.username,
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             color: Colors.black,
          //                             fontWeight: FontWeight.w800),
          //                       ),
          //                     ],
          //                   ),
          //                   const Text(
          //                     "View all",
          //                     style: TextStyle(
          //                       fontSize: 17,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.grey,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
