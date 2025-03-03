// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ChipItem extends StatelessWidget {
  const ChipItem({
    super.key,
    this.label,
    this.isSelected = false,
  });

  final String? label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      decoration: BoxDecoration(
        color: (!isSelected) ? (label) {
          switch (label) {
            case 'Family':
              return Colors.green.withOpacity(0.25);
            case 'Friend':
              return Colors.blue.withOpacity(0.25);
            case 'Work':
              return const Color.fromARGB(255, 183, 117, 255).withOpacity(0.25);
            case 'Neighborhood':
              return Colors.yellow.withOpacity(0.25);
            case 'Other':
              return Colors.grey.withOpacity(0.25);
            // case '':
            //   return MyColors.textColor.withOpacity(0.25);
            default:
              return MyColors.textColor.withOpacity(0.25);
          }
        }(label) : MyColors.textColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(100),
      ),
      // width: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(
              color: (!isSelected) ? (label) {
                switch (label) {
                  case 'Family':
                    return Colors.green;
                  case 'Friend':
                    return Colors.blue;
                  case 'Work':
                    return Color.fromARGB(255, 183, 117, 255);
                  case 'Neighborhood':
                    return Colors.yellow;
                  case 'Other':
                    return MyColors.textColor.withOpacity(0.5);
                  default:
                    return MyColors.textColor;
                }
              }(label) : MyColors.textColor,
              fontSize: 8,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
