import 'package:flutter/material.dart';
import 'package:flyin/constants.dart';

class FilterContainer extends StatelessWidget {
  final bool isSelected;
  final String name;

  FilterContainer({required this.name, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: (isSelected) ? Colors.blueAccent : Colors.blue[50],
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adjusts to the content size
        children: [
          Text(
            name,
            style: TextStyle(
                color: isSelected ? Colors.white : darkBlue, fontSize: 16.0),
          ),
          // const SizedBox(width: 3.0),
          // (isSelected) ? const Icon(Icons.check_rounded) : const Text(""),
        ],
      ),
    );
  }
}
