// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:contact_flutter/utils/colors.dart';
import 'package:contact_flutter/views/components/chip_item.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class ContactItem extends StatefulWidget {
  ContactItem({
    super.key,
    required this.avatar,
    required this.name,
    this.description,
    this.labels,
    // this.hasLabels = false,
    this.isSelected = false,
    this.isFavorite = false,
    this.isOffline = false,
  });

  final String avatar;
  final String name;
  final String? description;
  final List<String>? labels;
  // final bool hasLabels;
  bool isSelected;
  bool isFavorite;
  bool isOffline;

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  void toggleFavorite() {
    // nối api patch favorite nữa

    setState(() {
      widget.isFavorite = !widget.isFavorite;
    });
  }

  void toggleSelected() {
    setState(() {
      widget.isSelected = !widget.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        toggleSelected();
      },
      onTap: () {
        if (widget.isSelected) {
          toggleSelected();
        } else {
          // chuyển trang details
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: (widget.isSelected)
              ? MyColors.primaryColor
              : MyColors.backgroundColor,
          // color: MyColors.backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  widget.avatar,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ), // cần xử lý để offline
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.textColor,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (widget.labels!.isNotEmpty)
                          SizedBox(
                            height: 15,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.labels!.length,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    ChipItem(
                                      label: widget.labels![index],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    if (widget.description != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.description ?? '',
                          style: TextStyle(
                            fontSize: 10,
                            color: (widget.isSelected)
                                ? MyColors.textColor
                                : MyColors.white25,
                            height: 1,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleFavorite();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: (widget.isFavorite)
                          ? MyColors.textColor
                          : MyColors.textSecondaryColor,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      TablerIcons.star_filled,
                      color: (widget.isFavorite)
                          ? MyColors.textColor
                          : MyColors.white25,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
