// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_create_media_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchCreateMediaItemsResponse _$BatchCreateMediaItemsResponseFromJson(
        Map<String, dynamic> json) =>
    BatchCreateMediaItemsResponse(
      (json['newMediaItemResults'] as List<dynamic>?)
          ?.map((e) => NewMediaItemResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BatchCreateMediaItemsResponseToJson(
        BatchCreateMediaItemsResponse instance) =>
    <String, dynamic>{
      'newMediaItemResults': instance.newMediaItemResults,
    };

NewMediaItemResult _$NewMediaItemResultFromJson(Map<String, dynamic> json) =>
    NewMediaItemResult(
      json['uploadToken'] as String,
      json['mediaItem'] == null
          ? null
          : MediaItem.fromJson(json['mediaItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewMediaItemResultToJson(NewMediaItemResult instance) =>
    <String, dynamic>{
      'uploadToken': instance.uploadToken,
      'mediaItem': instance.mediaItem,
    };
