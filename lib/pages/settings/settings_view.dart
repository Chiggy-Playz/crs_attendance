import 'package:crs_attendance/config/constants.dart';
import 'package:crs_attendance/pages/settings/widgets/settings_group_widget.dart';
import 'package:crs_attendance/pages/settings/widgets/theme_settings_group.dart';
import 'package:crs_attendance/providers/settings/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const String routePath = '/settings';
  static const String routeName = 'settings';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final shorebirdCodePush = ShorebirdCodePush();

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
              ]),
              SettingsGroupWidget(title: "About", children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("Version"),
                  subtitle: Text(cAppVersion),
                ),
                FutureBuilder(
                  future: shorebirdInfo(),
                  builder: (context, snapshot) {
                    String subtitle;
                    if (snapshot.connectionState == ConnectionState.done) {
                      subtitle = "${snapshot.data?.$1}";
                    } else {
                      subtitle = "Loading...";
                    }
                    bool updateAvailable = snapshot.data?.$2 == true;
                    return ListTile(
                      leading: const Icon(Icons.update),
                      title: const Text("Patch Version"),
                      subtitle: Text(subtitle),
                      trailing: updateAvailable
                          ? const Icon(Icons.new_releases)
                          : null,
                      onTap: updateAvailable ? shorebirdCodePush.downloadUpdateIfAvailable : null,
                    );
                  },
                ),
              ])
            ],
          );
        });
  }

  Future<(int, bool)> shorebirdInfo() async {
    return (
      await shorebirdCodePush.currentPatchNumber() ?? 0,
      await shorebirdCodePush.isNewPatchAvailableForDownload()
    );
  }
}
