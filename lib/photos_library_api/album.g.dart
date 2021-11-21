// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album(
    json['id'] as String?,
    json['title'] as String?,
    json['productUrl'] as String?,
    json['isWriteable'] as bool?,
    json['shareInfo'] == null
        ? null
        : ShareInfo.fromJson(json['shareInfo'] as Map<String, dynamic>),
    json['mediaItemsCount'] as String?,
    json['coverPhotoBaseUrl'] as String?,
    json['coverPhotoMediaItemId'] as String?,
  );
}

Map<String, dynamic> _$AlbumToJson(Album instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('productUrl', instance.productUrl);
  writeNotNull('isWriteable', instance.isWriteable);
  writeNotNull('shareInfo', instance.shareInfo);
  writeNotNull('mediaItemsCount', instance.mediaItemsCount);
  writeNotNull('coverPhotoBaseUrl', instance.coverPhotoBaseUrl);
  writeNotNull('coverPhotoMediaItemId', instance.coverPhotoMediaItemId);
  return val;
}

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) {
  return ShareInfo(
    json['sharedAlbumOptions'] == null
        ? null
        : SharedAlbumOptions.fromJson(
            json['sharedAlbumOptions'] as Map<String, dynamic>),
    json['shareableUrl'] as String?,
    json['shareToken'] as String?,
    json['isJoined'] as bool?,
  );
}

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sharedAlbumOptions', instance.sharedAlbumOptions);
  writeNotNull('shareableUrl', instance.shareableUrl);
  writeNotNull('shareToken', instance.shareToken);
  writeNotNull('isJoined', instance.isJoined);
  return val;
}

SharedAlbumOptions _$SharedAlbumOptionsFromJson(Map<String, dynamic> json) {
  return SharedAlbumOptions(
    json['isCollaborative'] as bool?,
    json['isCommentable'] as bool?,
  );
}

Map<String, dynamic> _$SharedAlbumOptionsToJson(SharedAlbumOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isCollaborative', instance.isCollaborative);
  writeNotNull('isCommentable', instance.isCommentable);
  return val;
}
