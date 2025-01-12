// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$employeeRepositoryHash() =>
    r'afd1f624b02e3d35b43ea16f9217b94522a63812';

/// See also [employeeRepository].
@ProviderFor(employeeRepository)
final employeeRepositoryProvider =
    AutoDisposeProvider<EmployeeRepository>.internal(
  employeeRepository,
  name: r'employeeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$employeeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmployeeRepositoryRef = AutoDisposeProviderRef<EmployeeRepository>;
String _$employeesHash() => r'b946d8821c5a90b0548afc72251e2c14640a8d39';

/// See also [employees].
@ProviderFor(employees)
final employeesProvider =
    AutoDisposeStreamProvider<List<EmployeeModel>>.internal(
  employees,
  name: r'employeesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$employeesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmployeesRef = AutoDisposeStreamProviderRef<List<EmployeeModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
