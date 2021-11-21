import 'package:json_annotation/json_annotation.dart';

part 'search_media_items_request.g.dart';

@JsonSerializable()
class SearchMediaItemsRequest {
  SearchMediaItemsRequest(this.albumId, this.pageSize, this.pageToken);

  SearchMediaItemsRequest.albumId(this.albumId);

  factory SearchMediaItemsRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchMediaItemsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMediaItemsRequestToJson(this);

  String? albumId;
  int? pageSize;
  String? pageToken;
}
