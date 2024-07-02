import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyin/controller/profile_controller.dart';
import 'package:flyin/controller/video_controller.dart';
import 'package:flyin/models/video.dart';
import 'package:flyin/views/screens/Explore/video_details.dart';
import 'package:get/get.dart';

class ProfileVideoCard extends StatelessWidget {
  final String vid;
  final Video data;
  ProfileVideoCard({super.key, required this.vid, required this.data});

  final ProfileController profileController = Get.put(ProfileController());
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          videoController.views(data.id);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return VideoDetails(data: data);
          }));
        },
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                data.thumbnail,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  final views = profileController.profileVideos
                      .firstWhere((video) => video.id == data.id)
                      .views;
                  return Row(children: [
                    const Icon(
                      Icons.play_circle_outline_sharp,
                      color: Colors.white,
                    ),

                    Text(
                      views.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),

                    // Obx(() {
                    //   return Text(
                    //     data.views.toString(),
                    //     style: TextStyle(color: Colors.white),
                    //   );
                    // })
                  ]);
                })),
          ),
        ));
  }
}
