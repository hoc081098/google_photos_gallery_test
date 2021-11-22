import 'package:flutter/material.dart';
import 'package:gallery_test/photos_library_api/album.dart';

class ImagesListPage extends StatefulWidget {
  static const routeName = '/images_list';

  final Album album;

  const ImagesListPage({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  _ImagesListPageState createState() => _ImagesListPageState();
}

class _ImagesListPageState extends State<ImagesListPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
