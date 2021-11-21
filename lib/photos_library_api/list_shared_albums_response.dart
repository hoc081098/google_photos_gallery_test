import 'package:gallery_test/photos_library_api/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_shared_albums_response.g.dart';

@JsonSerializable()
class ListSharedAlbumsResponse {
  ListSharedAlbumsResponse(this.sharedAlbums, this.nextPageToken);

  factory ListSharedAlbumsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListSharedAlbumsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListSharedAlbumsResponseToJson(this);

  List<Album>? sharedAlbums;
  String? nextPageToken;
}
