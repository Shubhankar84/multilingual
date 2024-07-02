import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/search_controller.dart';
import 'package:flyin/controller/video_controller.dart';
import 'package:flyin/models/video.dart';
import 'package:flyin/views/screens/Explore/video_details.dart';
import 'package:flyin/views/widgets/filter.dart';
import 'package:flyin/views/widgets/search_box.dart';
import 'package:flyin/views/widgets/video_card.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool filter = false;

  final VideoController videoController = Get.put(VideoController());

  final SearchVideoController searchController =
      Get.put(SearchVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SearchBox(),
            InkWell(
              onTap: () {
                setState(() {
                  if (filter)
                    filter = false;
                  else {
                    filter = true;
                  }
                });
              },
              child: (filter)
                  ? const Icon(Icons.filter_alt)
                  : const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),

        (filter)
            ? SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedFilter[index] = !selectedFilter[index];
                            String temp = filters[index];

                            if (selectedFilterString.contains(filters[index])) {
                              selectedFilterString.remove(filters[index]);
                            } else {
                              selectedFilterString.add(filters[index]);
                            }
                            if (selectedFilterString.isEmpty) {
                              selectedFilter[0] = true;
                              selectedFilterString.add('All');
                            }

                            // if (selectedFilterString.length > 1) {
                            //   selectedFilter[0] = false;
                            //   selectedFilterString.remove('All');
                            // }

                            if (temp == 'All' &&
                                selectedFilterString.length > 1) {
                              for (int i = 1; i < selectedFilter.length; i++) {
                                selectedFilter[i] = false;
                              }
                              selectedFilter[0] = true;

                              selectedFilterString.clear();
                              selectedFilterString.add('All');
                            }

                            videoController.filterVideos();
                          });
                        },
                        child: FilterContainer(
                          isSelected: selectedFilter[index],
                          name: videoController.getVideoCategory(context, filters[index]),
                        ),
                      );
                    }),
              )
            : const SizedBox(
                height: 1,
              ),
        Expanded(
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                // itemCount: 2,
                itemCount: videoController.videoList.length,
                itemBuilder: ((context, index) {
                  final data = videoController.videoList[index];

                  return InkWell(
                    onTap: () {
                      videoController.views(data.id);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return VideoDetails(
                          data: data,
                          // index2: index,
                        );
                      })));
                    },
                    child: Column(
                      children: [
                        VideoCard(
                          data: data,
                        ),
                      ],
                    ),
                  );
                }));
          }),
        )
        // : Expanded(
        //     child: Obx(() {
        //       return ListView.builder(
        //         itemCount: searchController.searchedVideo.length,
        //         itemBuilder: ((context, index) {
        //           Video video = searchController.searchedVideo[index];
        //           return InkWell(
        //             onTap: () {
        //               videoController.views(video.id);
        //               Navigator.of(context)
        //                   .push(MaterialPageRoute(builder: ((context) {
        //                 return VideoDetails(
        //                   // data: data,
        //                   index: index,
        //                 );
        //               })));
        //             },
        //             child: Column(
        //               children: [
        //                 VideoCard(
        //                   data: video,
        //                 ),
        //               ],
        //             ),
        //           );
        //         }),
        //       );
        //     }),
        //   )
      ],
    ));
  }
}
