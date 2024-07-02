// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flyin/models/video.dart';
import 'package:flyin/views/screens/Upload/success_screen.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );

    return compressedVideo!.file;
  }

  Future<String> _uploadToVideoStorage(String id, String videoPath) async {
    // Get.snackbar('Uploading.', "2. Upload video storage");
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    // Get.snackbar('Uploading.', "3. Upload Image Storage");
    Reference ref =
        FirebaseStorage.instance.ref().child('thumbnails').child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video function
  uploadVideo(
    String title,
    String caption,
    String location,
    String category,
    String videoPath,
  ) async {
    try {
      // Get.snackbar('Uploading.', "1. called uploadVideo");
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // get id
      var allDocs = await FirebaseFirestore.instance.collection('videos').get();
      var len = allDocs.docs.length;
      String videoUrl = await _uploadToVideoStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        title: title.toUpperCase(),
        uid: uid,
        id: "Video $len",
        likes: [],
        dislikes: [],
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        location: location,
        views: 0,
        category: category,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      // Get.snackbar('Uploading.', "4. Upload Image Done");

      await FirebaseFirestore.instance
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());

      Get.back();
      // Get.snackbar('Success', "Video Uploaded Successfully!");
      Get.offAll(VideUploadSuccess());
    } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }
}
