import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 56,
        height: 56,
        child: LoadingIndicator(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
          indicatorType: Indicator.ballScaleMultiple,
        ),
      ),
    );
  }
}
