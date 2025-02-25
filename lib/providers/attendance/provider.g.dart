// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendanceRepositoryHash() =>
    r'511f887243f56b3b19224c21540195df461f586f';

/// See also [attendanceRepository].
@ProviderFor(attendanceRepository)
final attendanceRepositoryProvider =
    AutoDisposeProvider<AttendanceRepository>.internal(
  attendanceRepository,
  name: r'attendanceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendanceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AttendanceRepositoryRef = AutoDisposeProviderRef<AttendanceRepository>;
String _$attendanceHash() => r'7c2e375f5ef6a9ef9d788c8708486f619a6b008c';

/// See also [attendance].
@ProviderFor(attendance)
final attendanceProvider =
    AutoDisposeStreamProvider<List<AttendanceModel>>.internal(
  attendance,
  name: r'attendanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$attendanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AttendanceRef = AutoDisposeStreamProviderRef<List<AttendanceModel>>;
String _$attendanceByDateHash() => r'23183de17634b1b6446a45bf1f3825bab8500078';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [attendanceByDate].
@ProviderFor(attendanceByDate)
const attendanceByDateProvider = AttendanceByDateFamily();

/// See also [attendanceByDate].
class AttendanceByDateFamily extends Family<AsyncValue<List<AttendanceModel>>> {
  /// See also [attendanceByDate].
  const AttendanceByDateFamily();

  /// See also [attendanceByDate].
  AttendanceByDateProvider call(
    DateTime date,
  ) {
    return AttendanceByDateProvider(
      date,
    );
  }

  @override
  AttendanceByDateProvider getProviderOverride(
    covariant AttendanceByDateProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceByDateProvider';
}

/// See also [attendanceByDate].
class AttendanceByDateProvider
    extends AutoDisposeFutureProvider<List<AttendanceModel>> {
  /// See also [attendanceByDate].
  AttendanceByDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => attendanceByDate(
            ref as AttendanceByDateRef,
            date,
          ),
          from: attendanceByDateProvider,
          name: r'attendanceByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendanceByDateHash,
          dependencies: AttendanceByDateFamily._dependencies,
          allTransitiveDependencies:
              AttendanceByDateFamily._allTransitiveDependencies,
          date: date,
        );

  AttendanceByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<List<AttendanceModel>> Function(AttendanceByDateRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AttendanceByDateProvider._internal(
        (ref) => create(ref as AttendanceByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AttendanceModel>> createElement() {
    return _AttendanceByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendanceByDateRef
    on AutoDisposeFutureProviderRef<List<AttendanceModel>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _AttendanceByDateProviderElement
    extends AutoDisposeFutureProviderElement<List<AttendanceModel>>
    with AttendanceByDateRef {
  _AttendanceByDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as AttendanceByDateProvider).date;
}

String _$attendanceByEmployeeHash() =>
    r'b1884e29a58f8ca804d526d9be3e4d28cc9e1638';

/// See also [attendanceByEmployee].
@ProviderFor(attendanceByEmployee)
const attendanceByEmployeeProvider = AttendanceByEmployeeFamily();

/// See also [attendanceByEmployee].
class AttendanceByEmployeeFamily
    extends Family<AsyncValue<List<AttendanceModel>>> {
  /// See also [attendanceByEmployee].
  const AttendanceByEmployeeFamily();

  /// See also [attendanceByEmployee].
  AttendanceByEmployeeProvider call(
    String employeeId,
    DateTimeRange dateRange,
  ) {
    return AttendanceByEmployeeProvider(
      employeeId,
      dateRange,
    );
  }

  @override
  AttendanceByEmployeeProvider getProviderOverride(
    covariant AttendanceByEmployeeProvider provider,
  ) {
    return call(
      provider.employeeId,
      provider.dateRange,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceByEmployeeProvider';
}

/// See also [attendanceByEmployee].
class AttendanceByEmployeeProvider
    extends AutoDisposeFutureProvider<List<AttendanceModel>> {
  /// See also [attendanceByEmployee].
  AttendanceByEmployeeProvider(
    String employeeId,
    DateTimeRange dateRange,
  ) : this._internal(
          (ref) => attendanceByEmployee(
            ref as AttendanceByEmployeeRef,
            employeeId,
            dateRange,
          ),
          from: attendanceByEmployeeProvider,
          name: r'attendanceByEmployeeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendanceByEmployeeHash,
          dependencies: AttendanceByEmployeeFamily._dependencies,
          allTransitiveDependencies:
              AttendanceByEmployeeFamily._allTransitiveDependencies,
          employeeId: employeeId,
          dateRange: dateRange,
        );

  AttendanceByEmployeeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.employeeId,
    required this.dateRange,
  }) : super.internal();

  final String employeeId;
  final DateTimeRange dateRange;

  @override
  Override overrideWith(
    FutureOr<List<AttendanceModel>> Function(AttendanceByEmployeeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AttendanceByEmployeeProvider._internal(
        (ref) => create(ref as AttendanceByEmployeeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        employeeId: employeeId,
        dateRange: dateRange,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AttendanceModel>> createElement() {
    return _AttendanceByEmployeeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceByEmployeeProvider &&
        other.employeeId == employeeId &&
        other.dateRange == dateRange;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, employeeId.hashCode);
    hash = _SystemHash.combine(hash, dateRange.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendanceByEmployeeRef
    on AutoDisposeFutureProviderRef<List<AttendanceModel>> {
  /// The parameter `employeeId` of this provider.
  String get employeeId;

  /// The parameter `dateRange` of this provider.
  DateTimeRange get dateRange;
}

class _AttendanceByEmployeeProviderElement
    extends AutoDisposeFutureProviderElement<List<AttendanceModel>>
    with AttendanceByEmployeeRef {
  _AttendanceByEmployeeProviderElement(super.provider);

  @override
  String get employeeId => (origin as AttendanceByEmployeeProvider).employeeId;
  @override
  DateTimeRange get dateRange =>
      (origin as AttendanceByEmployeeProvider).dateRange;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
