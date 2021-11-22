// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_album_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareAlbumResponse _$ShareAlbumResponseFromJson(Map<String, dynamic> json) =>
    ShareAlbumResponse(
      json['shareInfo'] == null
          ? null
          : ShareInfo.fromJson(json['shareInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShareAlbumResponseToJson(ShareAlbumResponse instance) =>
    <String, dynamic>{
      'shareInfo': instance.shareInfo,
    };
