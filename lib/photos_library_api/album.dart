import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  Album(this.id, this.title, this.productUrl, this.isWriteable, this.shareInfo,
      this.mediaItemsCount, this.coverPhotoBaseUrl, this.coverPhotoMediaItemId);

  Album.toCreate(this.title);

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String? id;
  String? title;
  String? productUrl;
  bool? isWriteable;
  ShareInfo? shareInfo;
  String? mediaItemsCount;
  String? coverPhotoBaseUrl;
  String? coverPhotoMediaItemId;
}

@JsonSerializable()
class ShareInfo {
  ShareInfo(this.sharedAlbumOptions, this.shareableUrl, this.shareToken,
      this.isJoined);

  factory ShareInfo.fromJson(Map<String, dynamic> json) =>
      _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);

  SharedAlbumOptions? sharedAlbumOptions;
  String? shareableUrl;
  String? shareToken;
  bool? isJoined;
}

@JsonSerializable()
class SharedAlbumOptions {
  SharedAlbumOptions(this.isCollaborative, this.isCommentable);

  // Full collaboration enables the addition of media and commenting.
  SharedAlbumOptions.fullCollaboration() : this(true, true);

  factory SharedAlbumOptions.fromJson(Map<String, dynamic> json) =>
      _$SharedAlbumOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$SharedAlbumOptionsToJson(this);

  bool? isCollaborative;
  bool? isCommentable;
}
