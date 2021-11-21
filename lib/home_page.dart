import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_disposebag/flutter_disposebag.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_test/albums_list_page.dart';
import 'package:gallery_test/manager/photos_library_manager.dart';
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
          SvgPicture.asset(
            'assets/lockup_photos_horizontal.svg',
          ),
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
                        'Google',
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
          Navigator.pushNamedAndRemoveUntil(
            context,
            AlbumsListPage.routeName,
            ModalRoute.withName(Navigator.defaultRouteName),
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
