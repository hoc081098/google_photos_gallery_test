// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_shared_album_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinSharedAlbumResponse _$JoinSharedAlbumResponseFromJson(
        Map<String, dynamic> json) =>
    JoinSharedAlbumResponse(
      json['album'] == null
          ? null
          : Album.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JoinSharedAlbumResponseToJson(
        JoinSharedAlbumResponse instance) =>
    <String, dynamic>{
      'album': instance.album,
    };
