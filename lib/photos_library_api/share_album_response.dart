import 'package:gallery_test/photos_library_api/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'share_album_response.g.dart';

@JsonSerializable()
class ShareAlbumResponse {
  ShareAlbumResponse(this.shareInfo);

  factory ShareAlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$ShareAlbumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShareAlbumResponseToJson(this);

  ShareInfo? shareInfo;
}
