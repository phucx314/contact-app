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
  ContactListModelByFirstLetter _contactListModelMap =
      ContactListModelByFirstLetter(contacts: {});

  ContactModel get contactModel => _contactModel;
  get contactModelList => _contactModelList;
  get contactListModelMap => _contactListModelMap;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _totalContactsCount = 0;
  int get totalContactsCount => _totalContactsCount;

  int _currentPage = 1;
  bool _hasMore = true;
  int get currentPage => _currentPage;
  get hasMore => _hasMore;

  final ScrollController scrollController = ScrollController();

  HomeVm() {
    scrollController.addListener(_onScroll);
    _initData();
  }

  Future<void> _initData() async {
    try {
      await getTotalContactCount();
      await getContactsGroupedByFirstLetter(50, _currentPage);
    } catch (e) {
      print('Error init data: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasMore) {
      print('Reached bottom! Loading page: $_currentPage');
      getContactsGroupedByFirstLetter(50, _currentPage);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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

  // get total num of contacts
  Future<void> getTotalContactCount() async {
    try {
      _isLoading = true;
      notifyListeners();
      print('Fetching contacts...');
      _totalContactsCount = await _contactsServ.getTotalContactCount();
      print(_contactModelList);
    } catch (e) {
      print('ERROR: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // get all contacts grouped by first letter (nổ máy nên phải đổi qua xài pagination)
  Future<void> getContactsGroupedByFirstLetter(int limit, int page) async {
    if ((!_hasMore || _isLoading) && page > 1)
      return; // ko return quá sớm trong lần load đầu

    try {
      _isLoading = true;
      notifyListeners();
      print('_contactListModelMap.runtimeType');
      print(_contactListModelMap.runtimeType);
      print('Fetching contacts...');
      final newContacts =
          await _contactsServ.getContactsGroupedByFirstLetter(limit, page);
      // Log keys to debug
      print(
          'Current keys before merge: ${_contactListModelMap.contacts.keys.toList()}');
      print('New keys to merge: ${newContacts.contacts.keys.toList()}');

      if (newContacts.contacts.isEmpty) {
        _hasMore = false;
      } else {
        // Correctly merge the maps by letter
        newContacts.contacts.forEach((letter, contactsList) {
          if (_contactListModelMap.contacts.containsKey(letter)) { // đoạn này để check xem dsach letter đó đã có trc đó chưa, có rồi thì thêm vào chứ ko lại bị ghi đè mất
            // If letter already exists, add the new contacts to existing list
            _contactListModelMap.contacts[letter]!.addAll(contactsList);
          } else {
            // If letter is new, create a new entry
            _contactListModelMap.contacts[letter] = contactsList;
          }
        });

        // Update other pagination data
        // _totalContactsCount = newContacts.totalContacts;
        _currentPage = page + 1; // Move to next page for future requests

        print(
            'Merged data. Now have keys: ${_contactListModelMap.contacts.keys.toList()}');
        print(
            'Total contacts: ${_contactListModelMap.contacts.values.expand((e) => e).length}');
      }
    } catch (e) {
      print('ERROR: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
