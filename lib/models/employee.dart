import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'employee.mapper.dart';

class ColorMapper extends SimpleMapper<Color> {
  const ColorMapper();

  @override
  Color decode(dynamic value) {
    if (value is int) {
      return Color(value);
    }
    throw Exception();
  }

  @override
  dynamic encode(Color self) {
    return self.value;
  }
}

@MappableClass(includeCustomMappers: [ColorMapper()])
class EmployeeModel with EmployeeModelMappable {
  final String id;
  final String name;
  final Color color;
  final int salary;
  final bool disabled;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.color,
    required this.salary,
    this.disabled = false,
  });

  static const fromJson = EmployeeModelMapper.fromJson;
  static const fromJsonString = EmployeeModelMapper.fromJsonString;
}
