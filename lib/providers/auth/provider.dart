import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crs_attendance/models/authstate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// With firebase I often find myself writing simple providers
// Usually, stream-based redirects is more than enough.
// Most of the auth-related logic is handled by the SDK
// https://github.com/lucavenir/go_router_riverpod/tree/master/firebase_example
final authProvider = StreamProvider<AuthState>((ref) async* {
  await for (final user in FirebaseAuth.instance.authStateChanges()) {
    if (user == null) {
      // User is not logged in
      yield AuthState(isAuthenticated: false, isAdmin: false, user: null);
    } else {
      // Check if the logged-in user is an admin
      final isAdmin = await _checkIfAdmin(user.uid);
      yield AuthState(isAuthenticated: true, isAdmin: isAdmin, user: user);
    }
  }
});

// Function to check if a user is an admin
Future<bool> _checkIfAdmin(String uid) async {
  try {
    await FirebaseFirestore.instance.collection('admins').doc(uid).get();

    return true;
  } on FirebaseException {
    return false;
  }
}
// ```````````
