import 'package:crs_attendance/pages/home/home_view.dart';
import 'package:crs_attendance/pages/loading/loading_page.dart';
import 'package:crs_attendance/pages/login/login.dart';
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
      final isAuth = authState.valueOrNull != null;

      final isSplash = state.matchedLocation == LoadingPage.routePath;
      if (isSplash) {
        return isAuth ? HomeView.routePath : LoginPage.routePath;
      }

      final isLoggingIn = state.matchedLocation == LoginPage.routePath;
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
        path: HomeView.routePath,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );

  return router;
}
