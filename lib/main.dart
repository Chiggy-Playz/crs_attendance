import 'package:crs_attendance/app.dart';
import 'package:crs_attendance/config/constants.dart';
import 'package:crs_attendance/config/mappers.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final info = await PackageInfo.fromPlatform();

  cAppName = info.appName;
  cPackageName = info.packageName;
  cAppVersion = info.version;
  cBuildNumber = info.buildNumber;

  MapperContainer.globals.use(const LocalDateTimeMapper());
  runApp(const ProviderScope(child: CrsAttendanceApp()));
}
