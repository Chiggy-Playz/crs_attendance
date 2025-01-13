import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'attendance.mapper.dart';

@MappableEnum()
enum AttendanceStatus {
  choose,
  present,
  absent,
  halfDay,
  holiday,
}

class TimeOfDayMapper extends SimpleMapper<TimeOfDay> {
  const TimeOfDayMapper();

  @override
  TimeOfDay decode(dynamic value) {
    if (value is String) {
      final parts = value.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }
    throw Exception('Cannot decode TimeOfDay from $value');
  }

  @override
  dynamic encode(TimeOfDay self) {
    return '${self.hour.toString().padLeft(2, '0')}:${self.minute.toString().padLeft(2, '0')}';
  }
}

@MappableClass(includeCustomMappers: [TimeOfDayMapper()])
class AttendanceModel with AttendanceModelMappable {
  final AttendanceStatus status;
  final String employeeId;
  final DateTime date;
  final TimeOfDay? timeIn;
  final TimeOfDay? timeOut;
  final String? remarks;

  AttendanceModel({
    required this.status,
    required this.employeeId,
    required this.date,
    this.timeIn,
    this.timeOut,
    this.remarks,
  });

  String get id => '${date.day}-${date.month}-${date.year}-$employeeId';

  static const fromJson = AttendanceModelMapper.fromJson;
  static const fromJsonString = AttendanceModelMapper.fromJsonString;
}
