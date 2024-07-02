import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyin/models/video.dart';
import 'package:get/get.dart';

class SearchVideoController extends GetxController {
  final Rx<List<Video>> _searchedVideo = Rx<List<Video>>([]);
  

  List<Video> get searchedVideo => _searchedVideo.value;

  searchVideo(String typedVideo) async {
    
    _searchedVideo.bindStream(FirebaseFirestore.instance
        .collection('videos')
        .where('title', isGreaterThanOrEqualTo: typedVideo.toUpperCase())
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }

      return retVal;
    }));
  }
}
