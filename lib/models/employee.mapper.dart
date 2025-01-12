// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'employee.dart';

class EmployeeModelMapper extends ClassMapperBase<EmployeeModel> {
  EmployeeModelMapper._();

  static EmployeeModelMapper? _instance;
  static EmployeeModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmployeeModelMapper._());
      MapperContainer.globals.useAll([ColorMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'EmployeeModel';

  static String _$id(EmployeeModel v) => v.id;
  static const Field<EmployeeModel, String> _f$id = Field('id', _$id);
  static String _$name(EmployeeModel v) => v.name;
  static const Field<EmployeeModel, String> _f$name = Field('name', _$name);
  static Color _$color(EmployeeModel v) => v.color;
  static const Field<EmployeeModel, Color> _f$color = Field('color', _$color);
  static int _$salary(EmployeeModel v) => v.salary;
  static const Field<EmployeeModel, int> _f$salary = Field('salary', _$salary);
  static DateTime _$createdAt(EmployeeModel v) => v.createdAt;
  static const Field<EmployeeModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static bool _$disabled(EmployeeModel v) => v.disabled;
  static const Field<EmployeeModel, bool> _f$disabled =
      Field('disabled', _$disabled, opt: true, def: false);

  @override
  final MappableFields<EmployeeModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #color: _f$color,
    #salary: _f$salary,
    #createdAt: _f$createdAt,
    #disabled: _f$disabled,
  };

  static EmployeeModel _instantiate(DecodingData data) {
    return EmployeeModel(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        color: data.dec(_f$color),
        salary: data.dec(_f$salary),
        createdAt: data.dec(_f$createdAt),
        disabled: data.dec(_f$disabled));
  }

  @override
  final Function instantiate = _instantiate;

  static EmployeeModel fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EmployeeModel>(map);
  }

  static EmployeeModel fromJsonString(String json) {
    return ensureInitialized().decodeJson<EmployeeModel>(json);
  }
}

mixin EmployeeModelMappable {
  String toJsonString() {
    return EmployeeModelMapper.ensureInitialized()
        .encodeJson<EmployeeModel>(this as EmployeeModel);
  }

  Map<String, dynamic> toJson() {
    return EmployeeModelMapper.ensureInitialized()
        .encodeMap<EmployeeModel>(this as EmployeeModel);
  }

  EmployeeModelCopyWith<EmployeeModel, EmployeeModel, EmployeeModel>
      get copyWith => _EmployeeModelCopyWithImpl(
          this as EmployeeModel, $identity, $identity);
  @override
  String toString() {
    return EmployeeModelMapper.ensureInitialized()
        .stringifyValue(this as EmployeeModel);
  }

  @override
  bool operator ==(Object other) {
    return EmployeeModelMapper.ensureInitialized()
        .equalsValue(this as EmployeeModel, other);
  }

  @override
  int get hashCode {
    return EmployeeModelMapper.ensureInitialized()
        .hashValue(this as EmployeeModel);
  }
}

extension EmployeeModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmployeeModel, $Out> {
  EmployeeModelCopyWith<$R, EmployeeModel, $Out> get $asEmployeeModel =>
      $base.as((v, t, t2) => _EmployeeModelCopyWithImpl(v, t, t2));
}

abstract class EmployeeModelCopyWith<$R, $In extends EmployeeModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      Color? color,
      int? salary,
      DateTime? createdAt,
      bool? disabled});
  EmployeeModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EmployeeModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmployeeModel, $Out>
    implements EmployeeModelCopyWith<$R, EmployeeModel, $Out> {
  _EmployeeModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmployeeModel> $mapper =
      EmployeeModelMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          Color? color,
          int? salary,
          DateTime? createdAt,
          bool? disabled}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (color != null) #color: color,
        if (salary != null) #salary: salary,
        if (createdAt != null) #createdAt: createdAt,
        if (disabled != null) #disabled: disabled
      }));
  @override
  EmployeeModel $make(CopyWithData data) => EmployeeModel(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      color: data.get(#color, or: $value.color),
      salary: data.get(#salary, or: $value.salary),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      disabled: data.get(#disabled, or: $value.disabled));

  @override
  EmployeeModelCopyWith<$R2, EmployeeModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EmployeeModelCopyWithImpl($value, $cast, t);
}
