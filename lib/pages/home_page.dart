import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_disposebag/flutter_disposebag.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_test/pages/albums_list_page.dart';
import 'package:gallery_test/manager/photos_library_manager.dart';
import 'package:gallery_test/pages/images_list_page.dart';
import 'package:gallery_test/utils/delay.dart';
import 'package:gallery_test/utils/snackbar.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with DisposeBagMixin {
  final isLoading$ = StateSubject(false);

  @override
  void initState() {
    super.initState();
    isLoading$.disposedBy(bag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/google_photos_logo.png',
            height: 256,
            width: 256,
            scale: 0.5,
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFde5246),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                elevation: 4,
              ),
              onPressed: onSignIn,
              child: RxStreamBuilder<bool>(
                stream: isLoading$,
                builder: (context, isLoading) {
                  if (isLoading) {
                    return const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.white,
                      ),
                    );
                  }

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sign in with Google',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void onSignIn() async {
    if (isLoading$.value) {
      return;
    }

    isLoading$.add(true);
    final manager = Provider.of<PhotosLibraryManager>(context);

    try {
      final user = await manager.signIn();

      if (!mounted) {
        return;
      }
      if (user == null) {
        context.showSnackBar('Cancelled');
      } else {
        context.showSnackBar('Sign in successfully');
        await delay(800);

        unawaited(
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeDashboardPage.routeName,
            (_) => false,
          ),
        );
      }
    } catch (e, s) {
      debugPrint('$e $s');
      if (mounted) {
        context.showSnackBar('Failed to sign in: $e');
      }
    } finally {
      if (!isLoading$.isClosed) {
        isLoading$.add(false);
      }
    }
  }
}

class HomeDashboardPage extends StatelessWidget {
  static const routeName = '/home_dashboard';

  const HomeDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [
          LogoutButton(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: [
          buildItem(
            context,
            'Albums',
            () => Navigator.pushNamed(context, AlbumsListPage.routeName),
            Colors.red,
          ),
          buildItem(
            context,
            'Photos',
            () => Navigator.pushNamed(context, ImagesListPage.routeName),
            Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget buildItem(
    BuildContext context,
    String title,
    void Function() onTap,
    Color color,
  ) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () => onSignOut(),
    );
  }

  void onSignOut() {
    final navigator = Navigator.of(context);

    void onError(Object e, StackTrace s) {
      debugPrint('$e $s');
      if (mounted) {
        context.showSnackBar('Failed to logout: $e');
      }
    }

    Provider.of<PhotosLibraryManager>(context)
        .logout()
        .then((_) => navigator.pushNamedAndRemoveUntil('/', (route) => false))
        .onError<Object>(onError);
  }
}
