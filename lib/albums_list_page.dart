import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:gallery_test/manager/photos_library_manager.dart';
import 'package:gallery_test/photos_library_api/album.dart';
import 'package:gallery_test/utils/snackbar.dart';
import 'package:gallery_test/widgets/error_widget.dart';
import 'package:gallery_test/widgets/loading_widget.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:stream_loader/stream_loader.dart';

class AlbumsListPage extends StatelessWidget {
  static const routeName = '/album_list';

  const AlbumsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Single<List<Album>> loaderFunction() => Single.fromCallable(
        Provider.of<PhotosLibraryManager>(context).getAlbums);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => onSignOut(context),
          ),
        ],
      ),
      body: LoaderWidget<List<Album>>(
        blocProvider: () => LoaderBloc(
          loaderFunction: loaderFunction,
          refresherFunction: loaderFunction,
          initialContent: [],
          logger: debugPrint,
        ),
        messageHandler: handleMessage,
        builder: (context, state, bloc) {
          if (state.error != null) {
            return MyErrorWidget(
              errorText: 'Error: ${state.error}',
              onPressed: bloc.fetch,
            );
          }
          if (state.isLoading) {
            return const LoadingWidget();
          }

          final items = state.content!;
          return RefreshIndicator(
            onRefresh: bloc.refresh,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                crossAxisCount: 2,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  AlbumWidgetItem(album: items[index]),
            ),
          );
        },
      ),
    );
  }

  void handleMessage(
    BuildContext context,
    LoaderMessage<List<Album>> message,
    LoaderBloc<List<Album>> bloc,
  ) {
    message.fold(
      onFetchFailure: (error, stackTrace) =>
          context.showSnackBar('Fetch error'),
      onFetchSuccess: (_) {},
      onRefreshSuccess: (data) => context.showSnackBar('Refresh success'),
      onRefreshFailure: (error, stackTrace) =>
          context.showSnackBar('Refresh error'),
    );
  }

  void onSignOut(BuildContext context) {
    Provider.of<PhotosLibraryManager>(context).logout().then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    }).catchError((e, s) {
      debugPrint('$e $s');
      context.showSnackBar('Failed to logout: $e');
    });
  }
}

class AlbumWidgetItem extends StatelessWidget {
  final Album album;

  const AlbumWidgetItem({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: album.coverPhotoBaseUrl ?? '',
              fit: BoxFit.cover,
              height: 400,
              placeholder: (context, url) => Container(
                constraints: const BoxConstraints.expand(),
                child: Image.asset(
                  'assets/images/picture.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
                child: Text(
                  album.title ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                width: double.infinity,
              ),
              alignment: AlignmentDirectional.center,
            ),
          ],
        ),
      ),
    );
  }
}
