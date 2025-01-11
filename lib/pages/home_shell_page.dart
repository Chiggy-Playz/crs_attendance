import 'package:crs_attendance/providers/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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

  int get index => navigatorShell.currentIndex;

  String getAppBarTitle(WidgetRef ref) {
    int index = navigatorShell.currentIndex;
    return navigationBarDestinations[index].label;
  }

  List<Widget> getAppBarActions(BuildContext context, WidgetRef ref) {
    if (index != 0) return [];

    // For home page
    return [
      IconButton(
        icon: const Icon(Icons.today_rounded),
        onPressed: () {
          ref.read(calendarControllerProvider).displayDate = DateTime.now();
        },
      )
    ];
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

  FloatingActionButton? getFAB(CalendarController calendarController) {
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarController = ref.watch(calendarControllerProvider);

    return Scaffold(
      appBar: getAppBar(context, ref),
      body: navigatorShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigatorShell.currentIndex,
        destinations: navigationBarDestinations,
        onDestinationSelected: onNavigationBarClicked,
      ),
      floatingActionButton: getFAB(calendarController),
    );
  }

  void onNavigationBarClicked(int index) {
    navigatorShell.goBranch(
      index,
      initialLocation: index == navigatorShell.currentIndex,
    );
  }
}
