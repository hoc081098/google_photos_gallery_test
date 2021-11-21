// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_albums_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAlbumsResponse _$ListAlbumsResponseFromJson(Map<String, dynamic> json) {
  return ListAlbumsResponse(
    (json['albums'] as List<dynamic>?)
        ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['nextPageToken'] as String?,
  );
}

Map<String, dynamic> _$ListAlbumsResponseToJson(ListAlbumsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('albums', instance.albums);
  writeNotNull('nextPageToken', instance.nextPageToken);
  return val;
}
