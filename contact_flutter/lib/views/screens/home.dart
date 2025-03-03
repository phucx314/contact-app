// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:contact_flutter/utils/colors.dart';
import 'package:contact_flutter/views/components/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../components/contact_item.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    this.numberOfContacts = 0,
  });

  final int numberOfContacts;

  @override
  Widget build(BuildContext context) {
    // var statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      floatingActionButton: CtaButton(
        isActivated: true,
        label: 'Add Contact',
        iconData: TablerIcons.user_plus,
      ),
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
                  'DISPLAYED CONTACTS - $numberOfContacts',
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
                            color: MyColors.textSecondaryColor,
                            width: 1,
                          ),
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
                            width: 1, color: MyColors.textSecondaryColor),
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
                            width: 1, color: MyColors.textSecondaryColor),
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
                            width: 1, color: MyColors.textSecondaryColor),
                      ),
                      child: Icon(
                        TablerIcons.dots,
                        color: MyColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // phần chính
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'A',
                                    style: TextStyle(color: MyColors.white25),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                padding: const EdgeInsets.only(bottom: 15),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: ContactItem(
                                      name: 'Name of CONTACT',
                                      description: 'LOL',
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
