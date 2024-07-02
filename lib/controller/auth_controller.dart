import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flyin/views/screens/Auth/otp_screen.dart';
import 'package:flyin/views/screens/Auth/signUp.dart';
import 'package:flyin/views/screens/Auth/wrapper.dart';
import 'package:flyin/views/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:flyin/models/user.dart' as model;
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage = Rx<File?>(null);
  late Rx<User?> _user;

  final Rx<bool> _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for sending the code i.e. otp to user
  sendCode(String phoneController) async {
    _isLoading.value = true;
    try {
      print(
          "Sending Code.................................. to ${phoneController}");
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phoneController',
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar(
              'Error occured',
              e.toString(),
            );
          },
          codeSent: (String vid, int? token) {
            _isLoading.value = false;
            Get.to(OtpScreen(phoneNo: phoneController, vid: vid));
          },
          codeAutoRetrievalTimeout: (vid) {});
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occured', e.code);
    } catch (e) {
      Get.snackbar('Error Occured', e.toString());
    }

    _isLoading.value = false;
  }

  // once user enters otp verify and login to user and direct to home screen
  signIn(String vid, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: vid,
      smsCode: code,
    );

    try {
      // await FirebaseAuth.instance
      //     .signInWithCredential(credential)
      //     .then((value) => Get.offAll(Wrapper()));

      await FirebaseAuth.instance.signInWithCredential(credential);

      await checkUserInFirestore();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error otp', e.code);
    } catch (e) {
      Get.snackbar('Error otp', e.toString());
    }
  }

  // sign out functionality
  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(const Wrapper());
    } catch (e) {
      Get.snackbar('Error Signout', e.toString());
    }
  }

  Future<void> checkUserInFirestore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        // User exists, navigate to home
        Get.offAll(() => const HomeScreen());
      } else {
        // New user, navigate to username input screen
        Get.offAll(() => SignUpScreen());
      }
    }
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void createUser(String username, File? image) async {
    _isLoading.value = true;
    if (username.isEmpty && image == null) {
      Get.snackbar('Cannot Register', "All Fields are mandatory");
      return;
    }
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String downloadUrl = '';
        if (image != null) {
          downloadUrl = await _uploadToStorage(image);
        }

        model.User users = model.User(
            name: username,
            uid: user.uid,
            phoneNo: user.phoneNumber ?? '',
            profilePhoto: downloadUrl);

        await _firestore.collection('users').doc(user.uid).set(users.toJson());

        // await _firestore.collection('users').doc(user.uid).set({
        //   'username': username,
        //   'phone': user.phoneNumber,
        //   'createdAt': FieldValue.serverTimestamp(),
        // });
        _isLoading.value = false;
        Get.offAll(() => const HomeScreen());
      } catch (e) {
        Get.snackbar('Error creatUser', e.toString());
      }
    } else {
      Get.snackbar("error CreateUser", 'User is null');
    }
    _isLoading.value = false;
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture');
    }

    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }
}
