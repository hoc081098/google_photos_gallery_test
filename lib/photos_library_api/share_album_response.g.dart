// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_album_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareAlbumResponse _$ShareAlbumResponseFromJson(Map<String, dynamic> json) {
  return ShareAlbumResponse(
    json['shareInfo'] == null
        ? null
        : ShareInfo.fromJson(json['shareInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShareAlbumResponseToJson(ShareAlbumResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('shareInfo', instance.shareInfo);
  return val;
}
