import 'package:gallery_test/photos_library_api/album.dart';
import 'package:gallery_test/photos_library_api/photos_library_api_client.dart';
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

  Future<void> logout() => _googleSignIn.signOut();
}
