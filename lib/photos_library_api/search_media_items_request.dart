import 'package:json_annotation/json_annotation.dart';

part 'search_media_items_request.g.dart';

@JsonSerializable()
class SearchMediaItemsRequest {
  SearchMediaItemsRequest(
      this.albumId, this.pageSize, this.pageToken, this.filters);

  SearchMediaItemsRequest.albumId(this.albumId);

  factory SearchMediaItemsRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchMediaItemsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMediaItemsRequestToJson(this);

  String? albumId;
  int? pageSize;
  String? pageToken;
  SearchMediaItemsRequestFilters? filters;
}

@JsonSerializable()
class SearchMediaItemsRequestFilters {
  SearchMediaItemsRequestFilters(this.mediaTypeFilter);

  factory SearchMediaItemsRequestFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchMediaItemsRequestFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMediaItemsRequestFiltersToJson(this);

  SearchMediaItemsRequestMediaTypeFilter? mediaTypeFilter;
}

@JsonSerializable()
class SearchMediaItemsRequestMediaTypeFilter {
  SearchMediaItemsRequestMediaTypeFilter(this.mediaTypes);

  factory SearchMediaItemsRequestMediaTypeFilter.fromJson(
          Map<String, dynamic> json) =>
      _$SearchMediaItemsRequestMediaTypeFilterFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SearchMediaItemsRequestMediaTypeFilterToJson(this);

  List<SearchMediaItemsRequestMediaType>? mediaTypes;
}

enum SearchMediaItemsRequestMediaType {
  ALL_MEDIA,
  VIDEO_lAll,
  PHOTO,
}
