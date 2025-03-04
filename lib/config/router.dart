import 'package:crs_attendance/pages/attendance/attendance_page.dart';
import 'package:crs_attendance/pages/employees/employee_page.dart';
import 'package:crs_attendance/pages/employees/employees_view.dart';
import 'package:crs_attendance/pages/home/home_view.dart';
import 'package:crs_attendance/pages/home_shell_page.dart';
import 'package:crs_attendance/pages/loading/loading_page.dart';
import 'package:crs_attendance/pages/login/login.dart';
import 'package:crs_attendance/pages/report/report_view.dart';
import 'package:crs_attendance/pages/settings/settings_view.dart';
import 'package:crs_attendance/pages/unauthorized/unauthorized.dart';
import 'package:crs_attendance/providers/auth/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authProvider);

  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: LoadingPage.routePath,
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authState.isLoading || authState.hasError) return null;

      // Here we guarantee that hasData == true, i.e. we have a readable value

      // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // Returning `null` means "we are not authorized"
      final isAuth = authState.valueOrNull?.isAuthenticated ?? false;
      final isAdmin = authState.valueOrNull?.isAdmin ?? false;

      final isSplash = state.matchedLocation == LoadingPage.routePath;
      final isLoggingIn = state.matchedLocation == LoginPage.routePath;

      if (isSplash) {
        if (!isAuth) return LoginPage.routePath;
        if (!isAdmin) return UnauthorizedPage.routePath;
        return HomeView.routePath;
      }

      if (isLoggingIn) return isAuth ? HomeView.routePath : null;

      return isAuth ? null : LoadingPage.routePath;
    },
    routes: [
      GoRoute(
        path: LoadingPage.routePath,
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        path: LoginPage.routePath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: UnauthorizedPage.routePath,
        builder: (context, state) => const UnauthorizedPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigatorShell) {
          return HomeShellPage(navigatorShell: navigatorShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HomeView.routePath,
                builder: (context, state) {
                  return const HomeView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: EmployeesView.routePath,
                builder: (context, state) {
                  return const EmployeesView();
                },
              ),
            ],
          ),
          StatefulShellBranch(routes: [
            GoRoute(
              path: ReportView.routePath,
              builder: (context, state) {
                return const ReportView();
              },

            )
          ]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: SettingsView.routePath,
                builder: (context, state) {
                  return const SettingsView();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: EmployeePage.routePath,
        name: EmployeePage.routeName,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EmployeePage(id: id == "new" ? null : id);
        },
      ),
      GoRoute(
        path: AttendancePage.routePath,
        name: AttendancePage.routeName,
        builder: (context, state) {
          final date = state.uri.queryParameters['date']!;
          return AttendancePage(date: date);
        },
      )
    ],
  );

  return router;
}
