import 'package:gallery_test/photos_library_api/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'join_shared_album_response.g.dart';

@JsonSerializable()
class JoinSharedAlbumResponse {
  JoinSharedAlbumResponse(this.album);

  factory JoinSharedAlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinSharedAlbumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JoinSharedAlbumResponseToJson(this);

  Album? album;
}
