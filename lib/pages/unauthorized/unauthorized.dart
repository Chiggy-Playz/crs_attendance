import 'package:crs_attendance/config/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UnauthorizedPage extends ConsumerWidget {
  const UnauthorizedPage({super.key});

  static const String routePath = '/unauthorized';
  static const String routeName = 'Unauthorized';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You are not an authorized admin and cannot access this data.",
              style: context.textTheme.titleSmall,
            ),
            const Gap(16),
            FilledButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Log out"),
              onPressed: () async {
                await GoogleSignIn().disconnect();
                await FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
