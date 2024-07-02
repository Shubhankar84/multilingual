import 'package:flutter/material.dart';
import 'package:flyin/views/screens/Explore/explore_page.dart';
import 'package:flyin/views/screens/Upload/add_video_screen.dart';
import 'package:flyin/views/screens/Upload/success_screen.dart';
import 'package:flyin/views/screens/profile/profile_screen.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = const Color.fromRGBO(55, 183, 195, 1);
const borderColor = Colors.grey;
const darkBlue = Color.fromRGBO(7, 52, 82, 1);
const headingColor = Color.fromRGBO(8, 131, 149, 1);
// https://colorhunt.co/palette/07195208839537b7c3ebf4f6

// pages
List pages = [
  ExplorePage(),
  const AddVideoScreen(),
  ProfileScreen(),
];

// filter list
List filters = [
  'All',
  'Entertainment',
  'Education',
  'Lifestyle',
  'Travel',
  'Gaming',
  'Sports',
  'Music',
  'Vlogs',
  'Technology',
];

// for keeping the track of selected filters
List<bool> selectedFilter =
    List.generate(filters.length, (index) => index == 0);

List<String> selectedFilterString = ['All'];
