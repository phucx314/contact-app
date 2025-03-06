// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:contact_flutter/utils/colors.dart';
import 'package:contact_flutter/viewmodels/home_vm.dart';
import 'package:contact_flutter/views/components/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../models/contact_model.dart';
import '../components/contact_item.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    // this.numberOfContacts = 0,
  });

  @override
  Widget build(BuildContext context) {
    // var statusBarHeight = MediaQuery.of(context).padding.top;
    HomeVm homeVm = Provider.of<HomeVm>(context);

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
                  // 'DISPLAYED CONTACTS - ${homeVm.contactListModelMap.contacts.values.fold<int>(0, (int previousValue, List<ContactModel> element) => previousValue + element.length)}',
                  'DISPLAYED CONTACTS - ${homeVm.totalContactsCount}',
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
            Consumer<HomeVm>(builder: (context, homeVm, _) {
              return Expanded(
                child: SingleChildScrollView(
                  controller: homeVm.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        homeVm.contactListModelMap.contacts.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    homeVm.contactListModelMap.contacts.length +
                                        1,
                                itemBuilder: (context, index1) {
                                  if (index1 ==
                                      homeVm.contactListModelMap.contacts
                                          .length) {
                                    return homeVm.isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : SizedBox.shrink();
                                  }
                                  final String contactGroup = homeVm
                                      .contactListModelMap.contacts.keys
                                      .elementAt(index1);
                                  final List<ContactModel> contacts = homeVm
                                          .contactListModelMap
                                          .contacts[contactGroup] ??
                                      [];
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            contactGroup
                                                .toString(), // LẤY ĐƯỢC RỒI
                                            style: TextStyle(
                                                color: MyColors.white25),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: contacts.length,
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        itemBuilder: (context, index2) {
                                          final contact = contacts[index2];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3),
                                            child: ContactItem(
                                              name: contact.name,
                                              avatar: contact.avatar,
                                              description: contact.description,
                                              labels: contact.labels,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
