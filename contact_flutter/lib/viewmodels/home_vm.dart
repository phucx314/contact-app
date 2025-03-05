// ignore_for_file: prefer_final_fields

import 'package:contact_flutter/models/contact_model.dart';
import 'package:contact_flutter/services/contacts_serv.dart';
import 'package:flutter/material.dart';

class HomeVm with ChangeNotifier {
  ContactsServ _contactsServ = ContactsServ();
  ContactModel _contactModel = ContactModel(
    id: '',
    avatar:
        'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png',
    name: '',
    isFavorite: false,
  );
  List<ContactModel> _contactModelList = [];
  ContactListModelByFirstLetter _contactListModelMap = ContactListModelByFirstLetter(contacts: {});

  ContactModel get contactModel => _contactModel;
  get contactModelList => _contactModelList;
  get contactListModelMap => _contactListModelMap;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeVm() {
    getContactsGroupedByFirstLetter();
  }

  // get all contacts
  Future<void> getAllContacts() async {
    try {
      _isLoading = true;
      notifyListeners();
      print('Fetching contacts...');
      _contactModelList = await _contactsServ.getAllContacts();
      print(_contactModelList);
    } catch (e) {
      print('ERROR: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // get all contacts grouped by first letter
  Future<void> getContactsGroupedByFirstLetter() async {
    try {
      _isLoading = true;
      notifyListeners();
      print('_contactListModelMap.runtimeType');
      print(_contactListModelMap.runtimeType);
      print('Fetching contacts...');
      _contactListModelMap = await _contactsServ.getContactsGroupedByFirstLetter();
      print(_contactListModelMap);
    } catch (e) {
      print('ERROR: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
