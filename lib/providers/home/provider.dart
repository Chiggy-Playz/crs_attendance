import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
CalendarController calendarController(Ref ref) {
  final controller = CalendarController();

  ref.onDispose(controller.dispose);

  return controller;
}
