import 'package:json_annotation/json_annotation.dart';

import 'album.dart';

part 'share_album_request.g.dart';

@JsonSerializable(createFactory: false)
class ShareAlbumRequest {
  ShareAlbumRequest(this.albumId, [this.sharedAlbumOptions]);

  Map<String, dynamic> toJson() => _$ShareAlbumRequestToJson(this);

  // Album ID is not included in the JSON encoding of this request.
  // It must be supplied separately to the call.
  @JsonKey(ignore: true)
  String albumId;

  SharedAlbumOptions? sharedAlbumOptions;
}
