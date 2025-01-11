import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isAdmin;
  final User? user;

  AuthState({
    required this.isAuthenticated,
    required this.isAdmin,
    required this.user,
  });
}