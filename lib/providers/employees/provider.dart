import 'package:crs_attendance/models/employee.dart';
import 'package:crs_attendance/providers/db_provider.dart';
import 'package:crs_attendance/repositories/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';


@riverpod
EmployeeRepository employeeRepository(Ref ref) {
  return EmployeeRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<EmployeeModel>> employees(Ref ref) {
  return ref.watch(employeeRepositoryProvider).watchEmployees();
}