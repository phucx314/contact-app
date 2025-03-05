import 'dart:convert';

import 'package:contact_flutter/models/contact_model.dart';
import 'package:contact_flutter/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ContactsServ {
  // get all contacts
  Future<List<ContactModel>> getAllContacts() async {
    final url = Uri.parse(ApiEnpoints.getContacts);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      // print('API Response: $jsonData');
      return jsonData.map((contact) => ContactModel.fromJson(contact)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  // get all contacts grouped by first letter
  Future<ContactListModelByFirstLetter>
      getContactsGroupedByFirstLetter() async {
    final url = Uri.parse(ApiEnpoints.getContactsGroupedByFirstLetter);
    final response = await http.get(url);

    print("RAW JSON: ${response.body}"); // Kiểm tra API trả về gì

    if (response.statusCode == 200) {
      // **Sửa chỗ này**: Decode JSON chính xác
    final Map<String, dynamic> jsonData =
        jsonDecode(utf8.decode(response.bodyBytes));

      return ContactListModelByFirstLetter.fromJson(
          jsonData as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load contacts');
    }
  }
}
