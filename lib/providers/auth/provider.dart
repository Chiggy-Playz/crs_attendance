import 'package:crs_attendance/models/authstate.dart';
import 'package:crs_attendance/repositories/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

// With firebase I often find myself writing simple providers
// Usually, stream-based redirects is more than enough.
// Most of the auth-related logic is handled by the SDK
// https://github.com/lucavenir/go_router_riverpod/tree/master/firebase_example
final authProvider = StreamProvider<AuthState>((ref) async* {
  final authRepository = ref.watch(authRepositoryProvider);

  await for (final user in authRepository.authStateChanges()) {
    if (user == null) {
      // User is not logged in
      yield AuthState(isAuthenticated: false, isAdmin: false, user: null);
    } else {
      // Check if the logged-in user is an admin
      final isAdmin = await authRepository.isAdmin(user.uid);
      yield AuthState(isAuthenticated: true, isAdmin: isAdmin, user: user);
    }
  }
});
