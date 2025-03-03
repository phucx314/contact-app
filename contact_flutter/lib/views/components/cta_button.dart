// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:contact_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class CtaButton extends StatelessWidget {
  const CtaButton({
    super.key,
    this.iconData = TablerIcons.icons,
    this.label = 'Button Action',
    this.isActivated = true,
    this.backgroundColor = MyColors.primaryColor,
  });

  final IconData iconData;
  final String label;
  final bool isActivated;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          iconData,
          color: (isActivated) ? MyColors.textColor : MyColors.white25,
          size: 18,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: (isActivated) ? MyColors.textColor : MyColors.white25,
            fontSize: 14,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: (isActivated)
              ? WidgetStatePropertyAll(backgroundColor)
              : WidgetStatePropertyAll(MyColors.backgroundSecondaryColor),
          overlayColor: WidgetStatePropertyAll(MyColors.white25),
          shadowColor: WidgetStatePropertyAll(
            MyColors.backgroundSecondaryColor.withOpacity(0.5),
          ),
          elevation: WidgetStatePropertyAll(5),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 25),
          ),
        ),
      ),
    );
  }
}
