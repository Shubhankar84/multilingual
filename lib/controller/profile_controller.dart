import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flyin/models/video.dart';
import 'package:get/get.dart';
import 'package:flyin/models/user.dart' as model;

class ProfileController extends GetxController {
  final Rx<List<Video>> _profileVideos = Rx<List<Video>>([]);
  late Rx<model.User> _userProfile = Rx<model.User>(model.User(
    name: '',
    uid: '',
    profilePhoto: '',
    phoneNo: '',
  ));
  final Rx<bool> _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final Rx<List<Video>> _otherProfileVideos = Rx<List<Video>>([]);
  late Rx<model.User> _otherUserProfiles = Rx<model.User>(model.User(
    name: '',
    uid: '',
    profilePhoto: '',
    phoneNo: '',
  ));

  model.User get user => _userProfile.value;
  List<Video> get profileVideos => _profileVideos.value;

  model.User get otheruser => _otherUserProfiles.value;
  List<Video> get otherProfileVideos => _otherProfileVideos.value;

  @override
  void onInit() {
    super.onInit();
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    _userProfile.bindStream(
      FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: userUid)
          .snapshots()
          .map((QuerySnapshot query) {
        if (query.docs.isNotEmpty) {
          return model.User.fromSnap(query.docs.first);
        } else {
          return model.User(
            name: '',
            uid: '',
            profilePhoto: '',
            phoneNo: '',
          );
        }
      }),
    );

    _profileVideos.bindStream(
      FirebaseFirestore.instance
          .collection('videos')
          .where('uid', isEqualTo: userUid)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Video> retVal = [];
        for (var element in query.docs) {
          retVal.add(Video.fromSnap(element));
        }
        return retVal;
      }),
    );
  }

  Future<bool> loadProfilePage(String userId) async {
    try {
      // Bind user profile stream
      _isLoading.value = true;
      // _profileVideos.value.clear();

      _userProfile.bindStream(
        FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: userId)
            .snapshots()
            .map((QuerySnapshot query) {
          if (query.docs.isNotEmpty) {
            return model.User.fromSnap(query.docs.first);
          } else {
            return model.User(
              name: '',
              uid: '',
              profilePhoto: '',
              phoneNo: '',
            );
          }
        }),
      );

      // Bind profile videos stream
      _profileVideos.bindStream(
        FirebaseFirestore.instance
            .collection('videos')
            .where('uid', isEqualTo: userId)
            .snapshots()
            .map((QuerySnapshot query) {
          List<Video> retVal = [];
          for (var element in query.docs) {
            retVal.add(Video.fromSnap(element));
          }
          return retVal;
        }),
      );
      _isLoading.value = false;

      return true; // Indicate success
    } catch (e) {
      print('Error loading profile page: $e');
      return false; // Indicate failure
    }
  }

  Future<bool> fetchProfile(String userId) async {
    bool success = await loadProfilePage(userId);
    if (success) {
      // Profile loaded successfully, proceed with UI updates or navigation
      return true;
    } else {
      // Handle error loading profile
      return false;
    }
  }

  @override
  void onClose() {
    _userProfile.close(); // Close the stream when the controller is disposed
    super.onClose();
  }
}
