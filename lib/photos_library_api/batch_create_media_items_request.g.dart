// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_create_media_items_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchCreateMediaItemsRequest _$BatchCreateMediaItemsRequestFromJson(
    Map<String, dynamic> json) {
  return BatchCreateMediaItemsRequest(
    json['albumId'] as String?,
    (json['newMediaItems'] as List<dynamic>)
        .map((e) => NewMediaItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['albumPosition'] == null
        ? null
        : AlbumPosition.fromJson(json['albumPosition'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BatchCreateMediaItemsRequestToJson(
    BatchCreateMediaItemsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('albumId', instance.albumId);
  val['newMediaItems'] = instance.newMediaItems;
  writeNotNull('albumPosition', instance.albumPosition);
  return val;
}

NewMediaItem _$NewMediaItemFromJson(Map<String, dynamic> json) {
  return NewMediaItem(
    json['description'] as String?,
    json['simpleMediaItem'] == null
        ? null
        : SimpleMediaItem.fromJson(
            json['simpleMediaItem'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewMediaItemToJson(NewMediaItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('simpleMediaItem', instance.simpleMediaItem);
  return val;
}

SimpleMediaItem _$SimpleMediaItemFromJson(Map<String, dynamic> json) {
  return SimpleMediaItem(
    json['uploadToken'] as String,
  );
}

Map<String, dynamic> _$SimpleMediaItemToJson(SimpleMediaItem instance) =>
    <String, dynamic>{
      'uploadToken': instance.uploadToken,
    };

AlbumPosition _$AlbumPositionFromJson(Map<String, dynamic> json) {
  return AlbumPosition(
    json['relativeMediaItemId'] as String?,
    json['relativeEnrichmentItemId'] as String?,
    _$enumDecode(_$PositionTypeEnumMap, json['position']),
  );
}

Map<String, dynamic> _$AlbumPositionToJson(AlbumPosition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('relativeMediaItemId', instance.relativeMediaItemId);
  writeNotNull('relativeEnrichmentItemId', instance.relativeEnrichmentItemId);
  val['position'] = _$PositionTypeEnumMap[instance.position];
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$PositionTypeEnumMap = {
  PositionType.POSITION_TYPE_UNSPECIFIED: 'POSITION_TYPE_UNSPECIFIED',
  PositionType.FIRST_IN_ALBUM: 'FIRST_IN_ALBUM',
  PositionType.LAST_IN_ALBUM: 'LAST_IN_ALBUM',
  PositionType.AFTER_MEDIA_ITEM: 'AFTER_MEDIA_ITEM',
  PositionType.AFTER_ENRICHMENT_ITEM: 'AFTER_ENRICHMENT_ITEM',
};
