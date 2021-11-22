// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_media_items_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMediaItemsRequest _$SearchMediaItemsRequestFromJson(
        Map<String, dynamic> json) =>
    SearchMediaItemsRequest(
      json['albumId'] as String?,
      json['pageSize'] as int?,
      json['pageToken'] as String?,
      json['filters'] == null
          ? null
          : SearchMediaItemsRequestFilters.fromJson(
              json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchMediaItemsRequestToJson(
        SearchMediaItemsRequest instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'pageSize': instance.pageSize,
      'pageToken': instance.pageToken,
      'filters': instance.filters,
    };

SearchMediaItemsRequestFilters _$SearchMediaItemsRequestFiltersFromJson(
        Map<String, dynamic> json) =>
    SearchMediaItemsRequestFilters(
      json['mediaTypeFilter'] == null
          ? null
          : SearchMediaItemsRequestMediaTypeFilter.fromJson(
              json['mediaTypeFilter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchMediaItemsRequestFiltersToJson(
        SearchMediaItemsRequestFilters instance) =>
    <String, dynamic>{
      'mediaTypeFilter': instance.mediaTypeFilter,
    };

SearchMediaItemsRequestMediaTypeFilter
    _$SearchMediaItemsRequestMediaTypeFilterFromJson(
            Map<String, dynamic> json) =>
        SearchMediaItemsRequestMediaTypeFilter(
          (json['mediaTypes'] as List<dynamic>?)
              ?.map((e) =>
                  $enumDecode(_$SearchMediaItemsRequestMediaTypeEnumMap, e))
              .toList(),
        );

Map<String, dynamic> _$SearchMediaItemsRequestMediaTypeFilterToJson(
        SearchMediaItemsRequestMediaTypeFilter instance) =>
    <String, dynamic>{
      'mediaTypes': instance.mediaTypes
          ?.map((e) => _$SearchMediaItemsRequestMediaTypeEnumMap[e])
          .toList(),
    };

const _$SearchMediaItemsRequestMediaTypeEnumMap = {
  SearchMediaItemsRequestMediaType.ALL_MEDIA: 'ALL_MEDIA',
  SearchMediaItemsRequestMediaType.VIDEO_lAll: 'VIDEO_lAll',
  SearchMediaItemsRequestMediaType.PHOTO: 'PHOTO',
};
