import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:gallery_test/manager/photos_library_manager.dart';
import 'package:gallery_test/photos_library_api/album.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_test/photos_library_api/media_item.dart';
import 'package:gallery_test/widgets/empty_widget.dart';
import 'package:gallery_test/widgets/error_widget.dart';
import 'package:gallery_test/widgets/loading_widget.dart';
import 'package:gallery_test/utils/snackbar.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:stream_loader/stream_loader.dart';

class ImagesListPage extends StatelessWidget {
  static const routeName = '/images_list';

  final Album? album;

  const ImagesListPage({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = context.get<PhotosLibraryManager>();

    Single<List<MediaItem>> loaderFunction() =>
        Single.timer(null, const Duration(milliseconds: 300)).flatMapSingle(
            (_) => Single.fromCallable(() => manager.getPhotosByAlbum(album)));

    return Scaffold(
      appBar: AppBar(
        title: Text(album?.title ?? 'Photos'),
      ),
      body: LoaderWidget<List<MediaItem>>(
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
            return const MyLoadingWidget();
          }

          final images = state.content!;

          if (images.isEmpty) {
            return const MyEmptyWidget(message: 'Empty image');
          }

          return RefreshIndicator(
            onRefresh: bloc.refresh,
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: images.length,
              itemBuilder: (context, index) =>
                  ImageItemWidget(item: images[index]),
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
            ),
          );
        },
      ),
    );
  }

  void handleMessage(
    BuildContext context,
    LoaderMessage<List<MediaItem>> message,
    LoaderBloc<List<MediaItem>> bloc,
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

class ImageItemWidget extends StatelessWidget {
  final MediaItem item;

  const ImageItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(4.0));
    final width = ((MediaQuery.of(context).size.width - 8.0) / 2).floor();
    debugPrint('[DEBUG] width=$width');

    return Material(
      borderRadius: radius,
      elevation: 4.0,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Hero(
                child: ClipRRect(
                  borderRadius: radius,
                  child: CachedNetworkImage(
                    imageUrl: '${item.baseUrl}=w$width-h$width',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      constraints: const BoxConstraints.expand(),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/picture.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    errorWidget: (_, __, ___) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.error,
                              color: Theme.of(context).colorScheme.secondary),
                          const SizedBox(height: 4),
                          Text(
                            'Error',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                tag: item.id,
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Colors.black, Colors.transparent],
                    begin: AlignmentDirectional.bottomCenter,
                    end: AlignmentDirectional.topCenter,
                  ),
                  borderRadius: radius,
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  item.description ?? 'N/A',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
