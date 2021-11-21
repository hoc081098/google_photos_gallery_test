import 'package:gallery_test/photos_library_api/media_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'batch_create_media_items_response.g.dart';

@JsonSerializable()
class BatchCreateMediaItemsResponse {
  BatchCreateMediaItemsResponse(this.newMediaItemResults);

  factory BatchCreateMediaItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchCreateMediaItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchCreateMediaItemsResponseToJson(this);

  List<NewMediaItemResult>? newMediaItemResults;
}

@JsonSerializable()
class NewMediaItemResult {
  NewMediaItemResult(this.uploadToken, this.mediaItem);

  factory NewMediaItemResult.fromJson(Map<String, dynamic> json) =>
      _$NewMediaItemResultFromJson(json);

  Map<String, dynamic> toJson() => _$NewMediaItemResultToJson(this);

  String uploadToken;
  MediaItem? mediaItem;
}
