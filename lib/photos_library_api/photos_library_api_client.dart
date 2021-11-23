import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gallery_test/photos_library_api/album.dart';
import 'package:gallery_test/photos_library_api/batch_create_media_items_request.dart';
import 'package:gallery_test/photos_library_api/batch_create_media_items_response.dart';
import 'package:gallery_test/photos_library_api/create_album_request.dart';
import 'package:gallery_test/photos_library_api/get_album_request.dart';
import 'package:gallery_test/photos_library_api/join_shared_album_request.dart';
import 'package:gallery_test/photos_library_api/join_shared_album_response.dart';
import 'package:gallery_test/photos_library_api/list_albums_response.dart';
import 'package:gallery_test/photos_library_api/list_shared_albums_response.dart';
import 'package:gallery_test/photos_library_api/media_item.dart';
import 'package:gallery_test/photos_library_api/search_media_items_request.dart';
import 'package:gallery_test/photos_library_api/search_media_items_response.dart';
import 'package:gallery_test/photos_library_api/share_album_request.dart';
import 'package:gallery_test/photos_library_api/share_album_response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class PhotosLibraryApiClient {
  final http.Client _client;

  PhotosLibraryApiClient(this._authHeaders, this._client);

  final Future<Map<String, String>> _authHeaders;

  Future<Album> createAlbum(CreateAlbumRequest request) async {
    final response = await _client.post(
      Uri.parse('https://photoslibrary.googleapis.com/v1/albums'),
      body: jsonEncode(request),
      headers: await _authHeaders,
    );

    logError(response);

    return Album.fromJson(jsonDecode(response.body));
  }

  Future<JoinSharedAlbumResponse> joinSharedAlbum(
      JoinSharedAlbumRequest request) async {
    final response = await _client.post(
        Uri.parse('https://photoslibrary.googleapis.com/v1/sharedAlbums:join'),
        headers: await _authHeaders,
        body: jsonEncode(request));

    logError(response);

    return JoinSharedAlbumResponse.fromJson(jsonDecode(response.body));
  }

  Future<ShareAlbumResponse> shareAlbum(ShareAlbumRequest request) async {
    final response = await _client.post(
        Uri.parse(
            'https://photoslibrary.googleapis.com/v1/albums/${request.albumId}:share'),
        headers: await _authHeaders,
        body: jsonEncode(request));

    logError(response);

    return ShareAlbumResponse.fromJson(jsonDecode(response.body));
  }

  Future<Album> getAlbum(GetAlbumRequest request) async {
    final response = await _client.get(
        Uri.parse(
            'https://photoslibrary.googleapis.com/v1/albums/${request.albumId}'),
        headers: await _authHeaders);

    logError(response);

    return Album.fromJson(jsonDecode(response.body));
  }

  Future<ListAlbumsResponse> listAlbums() async {
    final response = await _client.get(
        Uri.parse('https://photoslibrary.googleapis.com/v1/albums?'
            'pageSize=50&excludeNonAppCreatedData=false'),
        headers: await _authHeaders);

    logError(response);

    return ListAlbumsResponse.fromJson(jsonDecode(response.body));
  }

  Future<ListSharedAlbumsResponse> listSharedAlbums() async {
    final response = await _client.get(
        Uri.parse('https://photoslibrary.googleapis.com/v1/sharedAlbums?'
            'pageSize=50&excludeNonAppCreatedData=true'),
        headers: await _authHeaders);

    logError(response);

    return ListSharedAlbumsResponse.fromJson(jsonDecode(response.body));
  }

  Future<String> uploadMediaItem(File image) async {
    // Get the filename of the image
    final filename = path.basename(image.path);

    // Set up the headers required for this request.
    final headers = <String, String>{};
    headers.addAll(await _authHeaders);
    headers['Content-type'] = 'application/octet-stream';
    headers['X-Goog-Upload-Protocol'] = 'raw';
    headers['X-Goog-Upload-File-Name'] = filename;

    // Make the HTTP request to upload the image. The file is sent in the body.
    final response = await _client.post(
      Uri.parse('https://photoslibrary.googleapis.com/v1/uploads'),
      body: image.readAsBytesSync(),
      headers: await _authHeaders,
    );

    logError(response);

    return response.body;
  }

  Future<SearchMediaItemsResponse> searchMediaItems(
      SearchMediaItemsRequest request) async {
    final response = await _client.post(
      Uri.parse('https://photoslibrary.googleapis.com/v1/mediaItems:search'),
      body: jsonEncode(request),
      headers: await _authHeaders,
    );

    logError(response);

    return SearchMediaItemsResponse.fromJson(jsonDecode(response.body));
  }

  Future<MediaItem> getMediaItem(String mediaItemId) async {
    final response = await _client.get(
        Uri.parse(
            'https://photoslibrary.googleapis.com/v1/mediaItems/$mediaItemId'),
        headers: await _authHeaders);

    logError(response);

    return MediaItem.fromJson(jsonDecode(response.body));
  }

  Future<BatchCreateMediaItemsResponse> batchCreateMediaItems(
      BatchCreateMediaItemsRequest request) async {
    debugPrint(request.toJson().toString());
    final response = await _client.post(
        Uri.parse(
            'https://photoslibrary.googleapis.com/v1/mediaItems:batchCreate'),
        body: jsonEncode(request),
        headers: await _authHeaders);

    logError(response);

    return BatchCreateMediaItemsResponse.fromJson(jsonDecode(response.body));
  }

  static void logError(final http.Response response) {
    debugPrint('[HTTP] >>> Url: ${response.request?.url}');
    debugPrint('[HTTP] >>> Body: ${response.body}');
    debugPrint('[HTTP] >>> Status code: ${response.statusCode}');
    debugPrint('[HTTP] >>> Reason phrase: ${response.reasonPhrase}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        '${response.body} ${response.statusCode}',
        uri: response.request?.url,
      );
    }
  }

  void dispose() => _client.close();
}
