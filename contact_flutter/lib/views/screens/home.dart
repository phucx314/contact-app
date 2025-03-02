// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:contact_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // var statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // pad
            SizedBox(
              height: 15,
            ),

            // num of contacts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DISPLAYED CONTACTS - 102',
                  style: TextStyle(
                    color: MyColors.white25,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // app bar
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: MyColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    // search bar
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: MyColors.backgroundSecondaryColor,
                              width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                TablerIcons.search,
                                color: MyColors.white25,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: MyColors.white25),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    // sort button
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 2, color: MyColors.backgroundSecondaryColor),
                      ),
                      child: Icon(
                        TablerIcons.sort_a_z,
                        color: MyColors.textColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    // filter button
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 2, color: MyColors.backgroundSecondaryColor),
                      ),
                      child: Icon(
                        TablerIcons.filter,
                        color: MyColors.textColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    // more
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 2, color: MyColors.backgroundSecondaryColor),
                      ),
                      child: Icon(
                        TablerIcons.dots,
                        color: MyColors.textColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),

            // phần chính
            // chờ be làm api phân loại sắp xếp theo chữ cái đầu
          ],
        ),
      ),
    );
  }
}
