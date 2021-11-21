import 'package:json_annotation/json_annotation.dart';

part 'join_shared_album_request.g.dart';

@JsonSerializable()
class JoinSharedAlbumRequest {
  JoinSharedAlbumRequest(this.shareToken);

  factory JoinSharedAlbumRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinSharedAlbumRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JoinSharedAlbumRequestToJson(this);

  String shareToken;
}
