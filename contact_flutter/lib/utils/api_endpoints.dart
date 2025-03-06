class ApiEnpoints {
  static const String baseUrl = 'http://192.168.1.82:5000/api';

  // Contacts APIs
  static const String contactUrl = '/contacts';
  // GET: get all contacts
  static String getContacts = '$baseUrl$contactUrl/get-contacts';
  // GET: total number of contacts
  static String getTotalContactCount = '$baseUrl$contactUrl/get-total-contacts';
  // GET: get contacts grouped by first letter (paginated)
  static String getContactsGroupedByFirstLetter(int limitPerPage, int pagePointer) => '$baseUrl$contactUrl/get-contacts-grouped-by-first-letter-paginated?limit=$limitPerPage&page=$pagePointer';
}