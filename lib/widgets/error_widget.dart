import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorText;
  final void Function() onPressed;

  const MyErrorWidget({
    Key? key,
    required this.errorText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  errorText,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 15),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                primary: themeData.colorScheme.surface,
                onPrimary: themeData.colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: themeData.primaryColor,
                    width: 1,
                  ),
                ),
              ),
              child: const Text('Retry'),
            ),
          ),
        ],
      ),
    );
  }
}
