import 'package:gallery_test/photos_library_api/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_albums_response.g.dart';

@JsonSerializable()
class ListAlbumsResponse {
  ListAlbumsResponse(this.albums, this.nextPageToken);

  factory ListAlbumsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListAlbumsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAlbumsResponseToJson(this);

  List<Album>? albums;
  String? nextPageToken;
}
