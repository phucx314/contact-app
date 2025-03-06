// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      id: json['id'] as String,
      avatar: json['avatar'] ??
          'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png',
      name: json['name'] as String,
      labels: (json['labels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['Other'],
      description: json['description'] as String?,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'name': instance.name,
      'labels': instance.labels,
      'description': instance.description,
      'isFavorite': instance.isFavorite,
    };

// ContactListModelByFirstLetter _$ContactListModelByFirstLetterFromJson(
//         Map<String, dynamic> json) =>
//     ContactListModelByFirstLetter(
//       contacts: (json['contacts'] as Map<String, dynamic>).map(
//         (k, e) => MapEntry(
//             k,
//             (e as List<dynamic>)
//                 .map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
//                 .toList()),
//       ),
//     );

ContactListModelByFirstLetter _$ContactListModelByFirstLetterFromJson(
        Map<String, dynamic> json) =>
    ContactListModelByFirstLetter(
      contacts: (json['contacts'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$ContactListModelByFirstLetterToJson(
        ContactListModelByFirstLetter instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
    };
