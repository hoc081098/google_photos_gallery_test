import 'dart:async';

import 'package:gallery_test/photos_library_api/album.dart';
import 'package:gallery_test/photos_library_api/media_item.dart';
import 'package:gallery_test/photos_library_api/photos_library_api_client.dart';
import 'package:gallery_test/photos_library_api/search_media_items_request.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart_ext/rxdart_ext.dart';

class UnauthenticatedException implements Exception {
  const UnauthenticatedException();

  @override
  String toString() => 'User is not authenticated! Please sign in.';
}

class PhotosLibraryManager {
  final GoogleSignIn _googleSignIn;

  late final StateStream<PhotosLibraryApiClient?> client$;

  PhotosLibraryManager(this._googleSignIn) {
    Stream<PhotosLibraryApiClient?> createClient(GoogleSignInAccount? value) {
      final headers = value?.authHeaders;

      return headers != null
          ? Rx.using<PhotosLibraryApiClient, PhotosLibraryApiClient>(
              () => PhotosLibraryApiClient(headers, http.Client()),
              (client) => Rx.never<PhotosLibraryApiClient>().startWith(client),
              (client) => client.dispose(),
            )
          : Stream.value(null);
    }

    client$ = _googleSignIn.onCurrentUserChanged
        .startWith(null)
        .distinct()
        .switchMap(createClient)
        .publishState(null)
      ..connect();
  }

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();

  /// Load albums into the model by retrieving the list of all albums owned
  /// by the user.
  Future<List<Album>> getAlbums() {
    final client = client$.value;
    return client == null
        ? Future.error(const UnauthenticatedException())
        : client.listAlbums().then((res) => res.albums ?? []);
  }

  Future<List<MediaItem>> getPhotosByAlbum(Album? album) async {
    final client = client$.value;
    if (client == null) {
      throw const UnauthenticatedException();
    }
    if (album == null) {
      return client
          .searchMediaItems(
            SearchMediaItemsRequest(
              null,
              100,
              null,
              SearchMediaItemsRequestFilters(
                SearchMediaItemsRequestMediaTypeFilter(
                  [SearchMediaItemsRequestMediaType.PHOTO],
                ),
              ),
            ),
          )
          .then((res) => res.mediaItems ?? []);
    }

    return client
        .searchMediaItems(
          SearchMediaItemsRequest(album.id, 100, null, null),
        )
        .then((res) =>
            res.mediaItems
                ?.where((m) => m.mimeType?.startsWith('image/') ?? false)
                .toList(growable: false) ??
            []);
  }

  Future<void> logout() => _googleSignIn.signOut();
}
