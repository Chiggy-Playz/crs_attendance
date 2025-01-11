import 'package:crs_attendance/pages/settings/widgets/theme_settings_group.dart';
import 'package:crs_attendance/providers/settings/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            ],
          );
        });
  }
}
//dws3wt54frws4rwseadswsgrxdedcyjccgf/v/e