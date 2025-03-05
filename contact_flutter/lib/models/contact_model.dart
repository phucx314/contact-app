import "package:json_annotation/json_annotation.dart";

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  final String id;
  final String avatar;
  final String name;
  final List<String> labels;
  final String? description;
  final bool isFavorite;

  ContactModel({
    required this.id,
    required this.avatar,
    required this.name,
    this.labels = const ['Other'],
    this.description,
    required this.isFavorite,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}

@JsonSerializable()
class ContactListModelByFirstLetter {
  final Map<String, List<ContactModel>> contacts;

  ContactListModelByFirstLetter({
    required this.contacts,
  });

  factory ContactListModelByFirstLetter.fromJson(Map<String, dynamic> json) => _$ContactListModelByFirstLetterFromJson(json);
  // factory ContactListModelByFirstLetter.fromJson(Map<String, dynamic> json) {
  //   return ContactListModelByFirstLetter(
  //     contacts: json.map(
  //       (key, value) => MapEntry(
  //         key,
  //         (value as List<dynamic>) // Ép kiểu value thành danh sách
  //             .map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }
}
