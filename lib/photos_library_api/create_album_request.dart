import 'package:gallery_test/photos_library_api/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_album_request.g.dart';

@JsonSerializable()
class CreateAlbumRequest {
  CreateAlbumRequest(this.album);

  factory CreateAlbumRequest.fromTitle(String title) =>
      CreateAlbumRequest(Album.toCreate(title));

  factory CreateAlbumRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAlbumRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAlbumRequestToJson(this);

  Album album;
}
