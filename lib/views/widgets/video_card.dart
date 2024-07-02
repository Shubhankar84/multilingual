import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/models/video.dart';
import 'package:flyin/views/widgets/profile_logo.dart';
import 'package:flyin/controller/video_controller.dart';
import 'package:get/get.dart';

class VideoCard extends StatelessWidget {
  final Video data;
  VideoCard({super.key, required this.data});

  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      // color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      height: 315,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber,
              ),
              child: InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      data.thumbnail,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5,
                ),
                child: Text(
                  data.title.toUpperCase(),
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.green,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4,
                    ),
                    child: Text(
                      data.location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Adds an ellipsis (...) if the text overflows
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileLogo(
                    url: data.profilePhoto,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    data.username,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.remove_red_eye_sharp),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    data.views.toString(),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                videoController.getVideoCategory(context, data.category),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // Row(
          //   children: [
          //     Text(
          //       "35 Views",
          //       style: TextStyle(
          //         fontSize: 15,
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
