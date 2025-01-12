import 'package:crs_attendance/config/extensions.dart';
import 'package:crs_attendance/providers/auth/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final user = await ref.read(authRepositoryProvider).signIn();
    if (user == null) {
      if (!mounted) return;
      context.showErrorSnackBar("Failed to sign in");
      return;
    }
  }
}
