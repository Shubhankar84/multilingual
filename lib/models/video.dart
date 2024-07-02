// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  String title;
  String location;
  int views;
  String category;
  String videoUrl;
  String thumbnail;
  List likes;
  List dislikes;
  String caption;
  String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.title,
    required this.location,
    required this.views,
    required this.category,
    required this.likes,
    required this.dislikes,
    required this.caption,
    required this.thumbnail,
    required this.videoUrl,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "title": title,
        "location": location,
        "views": views,
        "category": category,
        "likes": likes,
        "dislikes": dislikes,
        "caption": caption,
        "thumbnail": thumbnail,
        "videoUrl": videoUrl,
        "profilePhoto": profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      caption: snapshot['caption'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      title: snapshot['title'],
      location: snapshot['location'],
      views: snapshot['views'],
      category: snapshot['category'],
      likes: snapshot['likes'],
      dislikes: snapshot['dislikes'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
