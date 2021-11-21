// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_album_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAlbumRequest _$CreateAlbumRequestFromJson(Map<String, dynamic> json) {
  return CreateAlbumRequest(
    Album.fromJson(json['album'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateAlbumRequestToJson(CreateAlbumRequest instance) =>
    <String, dynamic>{
      'album': instance.album,
    };
