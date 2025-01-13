// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'attendance.dart';

class AttendanceStatusMapper extends EnumMapper<AttendanceStatus> {
  AttendanceStatusMapper._();

  static AttendanceStatusMapper? _instance;
  static AttendanceStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AttendanceStatusMapper._());
    }
    return _instance!;
  }

  static AttendanceStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AttendanceStatus decode(dynamic value) {
    switch (value) {
      case 'choose':
        return AttendanceStatus.choose;
      case 'present':
        return AttendanceStatus.present;
      case 'absent':
        return AttendanceStatus.absent;
      case 'halfDay':
        return AttendanceStatus.halfDay;
      case 'holiday':
        return AttendanceStatus.holiday;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AttendanceStatus self) {
    switch (self) {
      case AttendanceStatus.choose:
        return 'choose';
      case AttendanceStatus.present:
        return 'present';
      case AttendanceStatus.absent:
        return 'absent';
      case AttendanceStatus.halfDay:
        return 'halfDay';
      case AttendanceStatus.holiday:
        return 'holiday';
    }
  }
}

extension AttendanceStatusMapperExtension on AttendanceStatus {
  String toValue() {
    AttendanceStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AttendanceStatus>(this) as String;
  }
}

class AttendanceModelMapper extends ClassMapperBase<AttendanceModel> {
  AttendanceModelMapper._();

  static AttendanceModelMapper? _instance;
  static AttendanceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AttendanceModelMapper._());
      MapperContainer.globals.useAll([TimeOfDayMapper()]);
      AttendanceStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AttendanceModel';

  static AttendanceStatus _$status(AttendanceModel v) => v.status;
  static const Field<AttendanceModel, AttendanceStatus> _f$status =
      Field('status', _$status);
  static String _$employeeId(AttendanceModel v) => v.employeeId;
  static const Field<AttendanceModel, String> _f$employeeId =
      Field('employeeId', _$employeeId);
  static DateTime _$date(AttendanceModel v) => v.date;
  static const Field<AttendanceModel, DateTime> _f$date = Field('date', _$date);
  static TimeOfDay? _$timeIn(AttendanceModel v) => v.timeIn;
  static const Field<AttendanceModel, TimeOfDay> _f$timeIn =
      Field('timeIn', _$timeIn, opt: true);
  static TimeOfDay? _$timeOut(AttendanceModel v) => v.timeOut;
  static const Field<AttendanceModel, TimeOfDay> _f$timeOut =
      Field('timeOut', _$timeOut, opt: true);
  static String? _$remarks(AttendanceModel v) => v.remarks;
  static const Field<AttendanceModel, String> _f$remarks =
      Field('remarks', _$remarks, opt: true);

  @override
  final MappableFields<AttendanceModel> fields = const {
    #status: _f$status,
    #employeeId: _f$employeeId,
    #date: _f$date,
    #timeIn: _f$timeIn,
    #timeOut: _f$timeOut,
    #remarks: _f$remarks,
  };

  static AttendanceModel _instantiate(DecodingData data) {
    return AttendanceModel(
        status: data.dec(_f$status),
        employeeId: data.dec(_f$employeeId),
        date: data.dec(_f$date),
        timeIn: data.dec(_f$timeIn),
        timeOut: data.dec(_f$timeOut),
        remarks: data.dec(_f$remarks));
  }

  @override
  final Function instantiate = _instantiate;

  static AttendanceModel fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AttendanceModel>(map);
  }

  static AttendanceModel fromJsonString(String json) {
    return ensureInitialized().decodeJson<AttendanceModel>(json);
  }
}

mixin AttendanceModelMappable {
  String toJsonString() {
    return AttendanceModelMapper.ensureInitialized()
        .encodeJson<AttendanceModel>(this as AttendanceModel);
  }

  Map<String, dynamic> toJson() {
    return AttendanceModelMapper.ensureInitialized()
        .encodeMap<AttendanceModel>(this as AttendanceModel);
  }

  AttendanceModelCopyWith<AttendanceModel, AttendanceModel, AttendanceModel>
      get copyWith => _AttendanceModelCopyWithImpl(
          this as AttendanceModel, $identity, $identity);
  @override
  String toString() {
    return AttendanceModelMapper.ensureInitialized()
        .stringifyValue(this as AttendanceModel);
  }

  @override
  bool operator ==(Object other) {
    return AttendanceModelMapper.ensureInitialized()
        .equalsValue(this as AttendanceModel, other);
  }

  @override
  int get hashCode {
    return AttendanceModelMapper.ensureInitialized()
        .hashValue(this as AttendanceModel);
  }
}

extension AttendanceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AttendanceModel, $Out> {
  AttendanceModelCopyWith<$R, AttendanceModel, $Out> get $asAttendanceModel =>
      $base.as((v, t, t2) => _AttendanceModelCopyWithImpl(v, t, t2));
}

abstract class AttendanceModelCopyWith<$R, $In extends AttendanceModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {AttendanceStatus? status,
      String? employeeId,
      DateTime? date,
      TimeOfDay? timeIn,
      TimeOfDay? timeOut,
      String? remarks});
  AttendanceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AttendanceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AttendanceModel, $Out>
    implements AttendanceModelCopyWith<$R, AttendanceModel, $Out> {
  _AttendanceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AttendanceModel> $mapper =
      AttendanceModelMapper.ensureInitialized();
  @override
  $R call(
          {AttendanceStatus? status,
          String? employeeId,
          DateTime? date,
          Object? timeIn = $none,
          Object? timeOut = $none,
          Object? remarks = $none}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (employeeId != null) #employeeId: employeeId,
        if (date != null) #date: date,
        if (timeIn != $none) #timeIn: timeIn,
        if (timeOut != $none) #timeOut: timeOut,
        if (remarks != $none) #remarks: remarks
      }));
  @override
  AttendanceModel $make(CopyWithData data) => AttendanceModel(
      status: data.get(#status, or: $value.status),
      employeeId: data.get(#employeeId, or: $value.employeeId),
      date: data.get(#date, or: $value.date),
      timeIn: data.get(#timeIn, or: $value.timeIn),
      timeOut: data.get(#timeOut, or: $value.timeOut),
      remarks: data.get(#remarks, or: $value.remarks));

  @override
  AttendanceModelCopyWith<$R2, AttendanceModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AttendanceModelCopyWithImpl($value, $cast, t);
}
