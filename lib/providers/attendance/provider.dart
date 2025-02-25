import 'package:crs_attendance/models/attendance.dart';
import 'package:crs_attendance/providers/db_provider.dart';
import 'package:crs_attendance/repositories/attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
AttendanceRepository attendanceRepository(Ref ref) {
  return AttendanceRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<AttendanceModel>> attendance(Ref ref) {
  return ref.watch(attendanceRepositoryProvider).watchAttendance();
}

@riverpod
Future<List<AttendanceModel>> attendanceByDate(Ref ref, DateTime date) {
  return ref.watch(attendanceRepositoryProvider).getAttendanceByDate(date);
}

@riverpod
Future<List<AttendanceModel>> attendanceByEmployee(
    Ref ref, String employeeId, DateTimeRange dateRange) {
  return ref
      .watch(attendanceRepositoryProvider)
      .getAttendanceForEmployee(employeeId, dateRange);
}
