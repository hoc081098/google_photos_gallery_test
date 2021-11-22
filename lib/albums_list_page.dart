import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:gallery_test/manager/photos_library_manager.dart';
import 'package:gallery_test/photos_library_api/album.dart';
import 'package:gallery_test/utils/snackbar.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:stream_loader/stream_loader.dart';

class AlbumsListPage extends StatelessWidget {
  static const routeName = '/album_list';

  const AlbumsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Single<List<Album>> loaderFunction() => Single.fromCallable(
        Provider.of<PhotosLibraryManager>(context).getAlbums);

    return LoaderWidget<List<Album>>(
      blocProvider: () => LoaderBloc(
        loaderFunction: loaderFunction,
        refresherFunction: loaderFunction,
        initialContent: [],
        logger: debugPrint,
      ),
      messageHandler: handleMessage,
      builder: (context, state, bloc) {
        if (state.error != null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Error: ${state.error}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: bloc.fetch,
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        }
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final items = state.content!;

        return RefreshIndicator(
          onRefresh: bloc.refresh,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final comment = items[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.primaries[index % Colors.primaries.length],
                  maxRadius: 32,
                  minRadius: 32,
                  child: Text(comment.title?[0] ?? ''),
                ),
                title: Text(comment.title ?? ''),
                subtitle: Text(comment.mediaItemsCount ?? 'N/A'),
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        );
      },
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
                  'assets/picture.png',
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
