// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_media_items_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMediaItemsRequest _$SearchMediaItemsRequestFromJson(
    Map<String, dynamic> json) {
  return SearchMediaItemsRequest(
    json['albumId'] as String?,
    json['pageSize'] as int?,
    json['pageToken'] as String?,
  );
}

Map<String, dynamic> _$SearchMediaItemsRequestToJson(
    SearchMediaItemsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('albumId', instance.albumId);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('pageToken', instance.pageToken);
  return val;
}
