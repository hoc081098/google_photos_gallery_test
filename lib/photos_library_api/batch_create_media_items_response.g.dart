// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_create_media_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchCreateMediaItemsResponse _$BatchCreateMediaItemsResponseFromJson(
    Map<String, dynamic> json) {
  return BatchCreateMediaItemsResponse(
    (json['newMediaItemResults'] as List<dynamic>?)
        ?.map((e) => NewMediaItemResult.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BatchCreateMediaItemsResponseToJson(
    BatchCreateMediaItemsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('newMediaItemResults', instance.newMediaItemResults);
  return val;
}

NewMediaItemResult _$NewMediaItemResultFromJson(Map<String, dynamic> json) {
  return NewMediaItemResult(
    json['uploadToken'] as String,
    json['mediaItem'] == null
        ? null
        : MediaItem.fromJson(json['mediaItem'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewMediaItemResultToJson(NewMediaItemResult instance) {
  final val = <String, dynamic>{
    'uploadToken': instance.uploadToken,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mediaItem', instance.mediaItem);
  return val;
}
