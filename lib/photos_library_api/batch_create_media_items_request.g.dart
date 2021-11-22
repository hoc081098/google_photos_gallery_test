// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_create_media_items_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchCreateMediaItemsRequest _$BatchCreateMediaItemsRequestFromJson(
        Map<String, dynamic> json) =>
    BatchCreateMediaItemsRequest(
      json['albumId'] as String?,
      (json['newMediaItems'] as List<dynamic>)
          .map((e) => NewMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['albumPosition'] == null
          ? null
          : AlbumPosition.fromJson(
              json['albumPosition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BatchCreateMediaItemsRequestToJson(
        BatchCreateMediaItemsRequest instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'newMediaItems': instance.newMediaItems,
      'albumPosition': instance.albumPosition,
    };

NewMediaItem _$NewMediaItemFromJson(Map<String, dynamic> json) => NewMediaItem(
      json['description'] as String?,
      json['simpleMediaItem'] == null
          ? null
          : SimpleMediaItem.fromJson(
              json['simpleMediaItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewMediaItemToJson(NewMediaItem instance) =>
    <String, dynamic>{
      'description': instance.description,
      'simpleMediaItem': instance.simpleMediaItem,
    };

SimpleMediaItem _$SimpleMediaItemFromJson(Map<String, dynamic> json) =>
    SimpleMediaItem(
      json['uploadToken'] as String,
    );

Map<String, dynamic> _$SimpleMediaItemToJson(SimpleMediaItem instance) =>
    <String, dynamic>{
      'uploadToken': instance.uploadToken,
    };

AlbumPosition _$AlbumPositionFromJson(Map<String, dynamic> json) =>
    AlbumPosition(
      json['relativeMediaItemId'] as String?,
      json['relativeEnrichmentItemId'] as String?,
      $enumDecode(_$PositionTypeEnumMap, json['position']),
    );

Map<String, dynamic> _$AlbumPositionToJson(AlbumPosition instance) =>
    <String, dynamic>{
      'relativeMediaItemId': instance.relativeMediaItemId,
      'relativeEnrichmentItemId': instance.relativeEnrichmentItemId,
      'position': _$PositionTypeEnumMap[instance.position],
    };

const _$PositionTypeEnumMap = {
  PositionType.POSITION_TYPE_UNSPECIFIED: 'POSITION_TYPE_UNSPECIFIED',
  PositionType.FIRST_IN_ALBUM: 'FIRST_IN_ALBUM',
  PositionType.LAST_IN_ALBUM: 'LAST_IN_ALBUM',
  PositionType.AFTER_MEDIA_ITEM: 'AFTER_MEDIA_ITEM',
  PositionType.AFTER_ENRICHMENT_ITEM: 'AFTER_ENRICHMENT_ITEM',
};
