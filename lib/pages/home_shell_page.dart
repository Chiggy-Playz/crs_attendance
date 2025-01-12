import 'package:crs_attendance/pages/employees/employee_page.dart';
import 'package:crs_attendance/providers/home/provider.dart';
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

  FloatingActionButton? getFAB(BuildContext context, WidgetRef ref) {
    switch (index) {
      case 0:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.today_rounded),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(
              EmployeePage.routeName,
              pathParameters: {"id": "new"},
            );
          },
          child: const Icon(Icons.add),
        );
    }
    return null;
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
      floatingActionButton: getFAB(context, ref),
    );
  }

  void onNavigationBarClicked(int index) {
    navigatorShell.goBranch(
      index,
      initialLocation: index == navigatorShell.currentIndex,
    );
  }
}
