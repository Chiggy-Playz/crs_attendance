import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  static const routePath = '/loading';
  static const routeName = 'loading';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InitialLoadingPageState();
}

class _InitialLoadingPageState extends ConsumerState<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 16),
              Center(
                child: Text("Loading")
              )
            ]),
      ),
    );
  }
}
