import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/models/video.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class VideoController extends GetxController {
  // Make observable
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  // final Rx<List<Video>> _videoList2 = Rx<List<Video>>([]);
  // final Rx<Video> _video = Rx<Video>();
  List<Video> get videoList => _videoList.value;
  // List<Video> get videoList2 => _videoList2.value;

  Rx<int> _likes = Rx<int>(0);
  int get likes => _likes.value;
  void setLikes(likes) {
    _likes.value = likes;
  }

  // onInit runs when class 1st initalized
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // now bind the stream for collection of videos and map each video to our Video model
    _videoList.bindStream(FirebaseFirestore.instance
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];

      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }

  searchVideo(String typedVideo) async {
    if (typedVideo.isEmpty) {
      _videoList.bindStream(FirebaseFirestore.instance
          .collection('videos')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Video> retVal = [];

        for (var element in query.docs) {
          retVal.add(Video.fromSnap(element));
        }
        return retVal;
      }));
    } else {
      _videoList.bindStream(FirebaseFirestore.instance
          .collection('videos')
          .where('title', isGreaterThanOrEqualTo: typedVideo.toUpperCase())
          .where('title',
              isLessThanOrEqualTo: typedVideo.toUpperCase() + '\uf8ff')
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

  void filterVideos() {
    // List<String> selectedVideos = selectedFilterString;
    if (selectedFilterString.contains('All') || selectedFilterString.isEmpty) {
      // Fetch all videos
      _videoList.bindStream(FirebaseFirestore.instance
          .collection('videos')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Video> retVal = [];
        for (var element in query.docs) {
          retVal.add(Video.fromSnap(element));
        }
        return retVal;
      }));
    } else {
      // Fetch videos matching the selected categories
      _videoList.bindStream(FirebaseFirestore.instance
          .collection('videos')
          .where('category', whereIn: selectedFilterString)
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

  views(String id) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('videos').doc(id).get();

      await FirebaseFirestore.instance.collection('videos').doc(id).update({
        'views': FieldValue.increment(1),
      });
    } catch (e) {
      Get.snackbar('Error Views', e.toString());
    }
  }

  likeVideo(String id) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('videos').doc(id).get();

      // var uid = AuthController.instance.user.uid;
      final user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;

      if ((doc.data()! as dynamic)['likes'].contains(uid)) {
        await FirebaseFirestore.instance.collection('videos').doc(id).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await FirebaseFirestore.instance.collection('videos').doc(id).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
        // Get.snackbar('Likes', "video liked");

        if ((doc.data()! as dynamic)['dislikes'].contains(uid)) {
          await FirebaseFirestore.instance.collection('videos').doc(id).update({
            'dislikes': FieldValue.arrayRemove([uid]),
          });
        }
      }
    } catch (e) {
      Get.snackbar('Error like', e.toString());
    }
  }

  dislikeVideo(String id) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('videos').doc(id).get();

      // var uid =  AuthController.instance.user.uid;
      final user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;

      Get.snackbar(id, 'video id');

      if ((doc.data()! as dynamic)['dislikes'].contains(uid)) {
        await FirebaseFirestore.instance.collection('videos').doc(id).update({
          'dislikes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await FirebaseFirestore.instance.collection('videos').doc(id).update({
          'dislikes': FieldValue.arrayUnion([uid]),
        });

        if ((doc.data()! as dynamic)['likes'].contains(uid)) {
          await FirebaseFirestore.instance.collection('videos').doc(id).update({
            'likes': FieldValue.arrayRemove([uid]),
          });
        }
      }
    } catch (e) {
      Get.snackbar('Error Dislike', e.toString());
    }
  }

  String getVideoCategory(BuildContext context, String category) {
    switch (category) {
      case 'All':
        return AppLocalizations.of(context)!.all;
      case 'Entertainment':
        return AppLocalizations.of(context)!.entertainment;
      case 'Education':
        return AppLocalizations.of(context)!.education;
      case 'Lifestyle':
        return AppLocalizations.of(context)!.lifestyle;
      case 'Travel':
        return AppLocalizations.of(context)!.travel;
      case 'Gaming':
        return AppLocalizations.of(context)!.gaming;
      case 'Sports':
        return AppLocalizations.of(context)!.sports;
      case 'Music':
        return AppLocalizations.of(context)!.music;
      case 'Vlogs':
        return AppLocalizations.of(context)!.vlogs;
      case 'Technology':
        return AppLocalizations.of(context)!.technology;
      default:
        return category;
    }
  }
}
