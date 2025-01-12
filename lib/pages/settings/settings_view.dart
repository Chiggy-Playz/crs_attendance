import 'package:crs_attendance/pages/settings/widgets/settings_group_widget.dart';
import 'package:crs_attendance/pages/settings/widgets/theme_settings_group.dart';
import 'package:crs_attendance/providers/settings/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const String routePath = '/settings';
  static const String routeName = 'settings';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  @override
  Widget build(BuildContext context) {
    var settings = ref.watch(settingsNotifierProvider);
    return settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return const Center(
            child: Text(
                "Uh oh! Something went wrong while trying to load settings..."),
          );
        },
        data: (settings) {
          return ListView(
            children: [
              ThemeSettingsGroup(settings: settings),
              SettingsGroupWidget(title: "Account", children: [
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Sign Out"),
                  onTap: () async {
                    await GoogleSignIn().disconnect();
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ])
            ],
          );
        });
  }
}
//dws3wt54frws4rwseadswsgrxdedcyjccgf/v/e