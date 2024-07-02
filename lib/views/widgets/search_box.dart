import 'package:flutter/material.dart';
import 'package:flyin/controller/search_controller.dart';
import 'package:flyin/controller/video_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBox extends StatelessWidget {
  SearchBox({super.key});

  final SearchVideoController searchController = Get.put(SearchVideoController());
  final VideoController videoController = Get.put(VideoController());


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // color: Colors.amber,
          width: MediaQuery.of(context).size.width * 0.7,
          height: 50,
          child: TextFormField(
            onFieldSubmitted: (value) => videoController.searchVideo(value),
            decoration: InputDecoration(
              focusColor: Colors.amber,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              label: Text(AppLocalizations.of(context)!.search),
              prefixIcon: const Icon(Icons.search),
              suffix: InkWell(
                onTap: () {},
                child: Icon(Icons.format_align_center_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
