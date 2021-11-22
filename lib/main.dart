import 'package:disposebag/disposebag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:gallery_test/pages/albums_list_page.dart';
import 'package:gallery_test/pages/home_page.dart';
import 'package:gallery_test/manager/photos_library_manager.dart';
import 'package:gallery_test/pages/images_list_page.dart';
import 'package:gallery_test/photos_library_api/album.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RxStreamBuilder.checkStateStreamEnabled = !kReleaseMode;
  _setupLoggers();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    Provider.factory(
      (context) => PhotosLibraryManager(
        GoogleSignIn(
          scopes: [
            'profile',
            'https://www.googleapis.com/auth/photoslibrary',
            'https://www.googleapis.com/auth/photoslibrary.sharing',
          ],
        ),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      precacheImage(
        const AssetImage('assets/images/google_photos_logo.png'),
        context,
      ).ignore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
      routes: {
        HomeDashboardPage.routeName: (context) => const HomeDashboardPage(),
        AlbumsListPage.routeName: (context) => const AlbumsListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ImagesListPage.routeName) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) =>
                ImagesListPage(album: settings.arguments as Album?),
          );
        }
        return null;
      },
    );
  }
}

void _setupLoggers() {
  // set loggers to `null` to disable logging.
  DisposeBagConfigs.logger = kReleaseMode ? null : disposeBagDefaultLogger;

  debugPrint = kReleaseMode
      ? (String? message, {int? wrapWidth}) {}
      : debugPrintSynchronously;
}
