import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_test/photos_library_api/media_item.dart';
import 'package:gallery_test/utils/snackbar.dart';
import 'package:gallery_test/widgets/loading_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class ImageDetailPage extends StatefulWidget {
  static const routeName = '/image_detail';

  final MediaItem item;

  const ImageDetailPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  final isLoading$ = StateSubject(false);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    ).ignore();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    ).ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Theme.of(context).backgroundColor.withOpacity(0.8),
                Theme.of(context).backgroundColor.withOpacity(0.9),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
          ),
          child: Stack(
            children: <Widget>[
              _CenterImage(item: widget.item),
              _AppBar(item: widget.item),
              _DownloadButton(
                isLoading$: isLoading$,
                onDownloadImage: _downloadImage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadImage() async {
    final item = widget.item;

    final queryData = MediaQuery.of(context);
    final width =
        (queryData.size.shortestSide * queryData.devicePixelRatio).toInt();
    final height =
        (queryData.size.longestSide * queryData.devicePixelRatio).toInt();
    final downloadUrl = Uri.tryParse('${item.baseUrl}=w$width-h$height-d');
    if (downloadUrl == null) {
      return context.showSnackBar('Failed to get download url');
    }

    final targetPlatform = Theme.of(context).platform;
    isLoading$.add(true);

    try {
      // get external directory
      Directory? externalDir;
      switch (targetPlatform) {
        case TargetPlatform.android:
          externalDir = await getExternalStorageDirectory();
          break;
        case TargetPlatform.iOS:
          externalDir = await getApplicationDocumentsDirectory();
          break;
        default:
          return downloadDone('Not support target: $targetPlatform');
      }
      debugPrint('[DEBUG] externalDir=$externalDir');
      if (externalDir == null) {
        return downloadDone('Failed to get external directory');
      }

      final file =
          File(path.join(externalDir.path, 'flutterImages', item.filename));
      if (file.existsSync()) {
        await file.delete();
      }
      await file.create(recursive: true);

      debugPrint('[DEBUG] Start download $downloadUrl...');
      final cachedImageFile =
          await DefaultCacheManager().getSingleFile(downloadUrl.toString());
      await cachedImageFile.copy(file.path);
      await ImageGallerySaver.saveFile(file.path, name: item.filename);
      debugPrint('[DEBUG] Done download $downloadUrl...');

      downloadDone('Image downloaded successfully');
    } catch (e, s) {
      debugPrint('[ERROR] $e, $s');
      downloadDone('Failed to download image: $e');
    } finally {
      downloadDone(null);
    }
  }

  void downloadDone(String? message) {
    if (!mounted) {
      return;
    }
    if (message != null) {
      context.showSnackBar(message);
    }
    if (!isLoading$.isClosed) {
      isLoading$.add(false);
    }
  }
}

class _AppBar extends StatelessWidget {
  final MediaItem item;

  const _AppBar({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final closeButton = ClipOval(
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

    final textName = Expanded(
      child: Text(
        item.filename ?? 'N/A',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );

    return Positioned(
      child: Container(
        child: Row(
          children: <Widget>[
            closeButton,
            const SizedBox(width: 8.0),
            textName,
          ],
        ),
        height: kToolbarHeight,
        constraints: const BoxConstraints.expand(height: kToolbarHeight),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.black,
              Colors.transparent,
            ],
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            stops: [0.1, 0.9],
          ),
        ),
      ),
      top: 0.0,
      left: 0.0,
      right: 0.0,
    );
  }
}

class _CenterImage extends StatelessWidget {
  final MediaItem item;

  const _CenterImage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width =
        (queryData.size.shortestSide * queryData.devicePixelRatio).toInt();
    final height =
        (queryData.size.longestSide * queryData.devicePixelRatio).toInt();
    debugPrint('[DEBUG] w=$width-h=$height');

    return Center(
      child: Hero(
        tag: item.id,
        child: CachedNetworkImage(
          imageUrl: '${item.baseUrl}=w$width-h$height-d',
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
                  child: MyLoadingWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final StateStream<bool> isLoading$;
  final VoidCallback onDownloadImage;

  const _DownloadButton({
    Key? key,
    required this.isLoading$,
    required this.onDownloadImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: RxStreamBuilder<bool>(
        stream: isLoading$,
        builder: (context, isLoading) {
          return Row(
            children: <Widget>[
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              else
                const SizedBox.shrink(),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(24.0),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  onPressed: isLoading ? null : onDownloadImage,
                  child: const Text(
                    'Download',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
