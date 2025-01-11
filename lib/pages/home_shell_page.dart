import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const navigationBarDestinations = [
  NavigationDestination(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.group),
    label: 'Employees',
  ),
  NavigationDestination(
    icon: Icon(Icons.settings_rounded),
    label: 'Settings',
  ),
];

class HomeShellPage extends ConsumerWidget {
  const HomeShellPage({super.key, required this.navigatorShell});

  final StatefulNavigationShell navigatorShell;

  String getAppBarTitle(WidgetRef ref) {
    int index = navigatorShell.currentIndex;
    return navigationBarDestinations[index].label;
  }

  List<Widget> getAppBarActions(BuildContext context, WidgetRef ref) {
    return [];
  }

  AppBar? getAppBar(BuildContext context, WidgetRef ref) {
    // Don't show app bar on servers page
    return AppBar(
      title: Text(getAppBarTitle(ref)),
      actions: getAppBarActions(context, ref),
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: getAppBar(context, ref),
      body: navigatorShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigatorShell.currentIndex,
        destinations: navigationBarDestinations,
        onDestinationSelected: onNavigationBarClicked,
      ),
    );
  }

  void onNavigationBarClicked(int index) {
    navigatorShell.goBranch(
      index,
      initialLocation: index == navigatorShell.currentIndex,
    );
  }
}
