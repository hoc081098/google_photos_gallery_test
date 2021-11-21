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
