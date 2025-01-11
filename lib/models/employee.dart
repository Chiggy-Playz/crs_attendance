import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'employee.mapper.dart';

@MappableClass()
class EmployeeModel with EmployeeModelMappable {
  final String id;
  final String name;
  final Color color;
  final int salary;


  EmployeeModel({
    required this.id,
    required this.name,
    required this.color,
    required this.salary,
  });

  static const fromJson = EmployeeModelMapper.fromJson;
  static const fromJsonString = EmployeeModelMapper.fromJsonString;
}