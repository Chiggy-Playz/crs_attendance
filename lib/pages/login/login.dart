import 'package:crs_attendance/config/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  static const String routePath = "/login";
  static const String routeName = "login";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: FilledButton.icon(
              icon: Image.asset(
                'assets/images/google.png',
                height: 32,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text("Sign in with Google"),
              ),
              onPressed: handleLogin,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin() async {
    final user = await signInWithGoogle();
    if (user == null) {
      if (!mounted) return;
      context.showErrorSnackBar("Failed to sign in");
      return;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCreds =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCreds.user;
    } catch (error) {
      // TODO: Add talker
      print(error);
    }

    return null;
  }
}
