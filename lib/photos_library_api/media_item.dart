import 'package:json_annotation/json_annotation.dart';

part 'media_item.g.dart';

@JsonSerializable()
class MediaItem {
  MediaItem(
      this.id, this.description, this.productUrl, this.baseUrl, this.mimeType);

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  String id;
  String? description;
  String? productUrl;
  String? baseUrl;
  String? mimeType;
}
