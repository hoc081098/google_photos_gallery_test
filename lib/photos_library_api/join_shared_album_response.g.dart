// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_shared_album_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinSharedAlbumResponse _$JoinSharedAlbumResponseFromJson(
    Map<String, dynamic> json) {
  return JoinSharedAlbumResponse(
    json['album'] == null
        ? null
        : Album.fromJson(json['album'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$JoinSharedAlbumResponseToJson(
    JoinSharedAlbumResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('album', instance.album);
  return val;
}
