// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_media_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMediaItemsResponse _$SearchMediaItemsResponseFromJson(
    Map<String, dynamic> json) {
  return SearchMediaItemsResponse(
    (json['mediaItems'] as List<dynamic>?)
        ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['nextPageToken'] as String?,
  );
}

Map<String, dynamic> _$SearchMediaItemsResponseToJson(
    SearchMediaItemsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mediaItems', instance.mediaItems);
  writeNotNull('nextPageToken', instance.nextPageToken);
  return val;
}
