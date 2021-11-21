// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_shared_albums_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSharedAlbumsResponse _$ListSharedAlbumsResponseFromJson(
    Map<String, dynamic> json) {
  return ListSharedAlbumsResponse(
    (json['sharedAlbums'] as List<dynamic>?)
        ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['nextPageToken'] as String?,
  );
}

Map<String, dynamic> _$ListSharedAlbumsResponseToJson(
    ListSharedAlbumsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sharedAlbums', instance.sharedAlbums);
  writeNotNull('nextPageToken', instance.nextPageToken);
  return val;
}
