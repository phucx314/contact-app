class ApiEnpoints {
  static const String baseUrl = 'http://192.168.1.8:5000/api';

  // Contacts APIs
  static const String contactUrl = '/contacts';
  // GET: get all contacts
  static String getContacts = '$baseUrl$contactUrl/get-contacts';
  // GET: get contacts grouped by first letter
  static String getContactsGroupedByFirstLetter = '$baseUrl$contactUrl/get-contacts-grouped-by-first-letter';
}