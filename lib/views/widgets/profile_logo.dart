import 'package:flutter/material.dart';

class ProfileLogo extends StatelessWidget {
  final String url;
  const ProfileLogo({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image(
          fit: BoxFit.fill,
          image: NetworkImage(url),
        ),
      ),
    );
  }
}
