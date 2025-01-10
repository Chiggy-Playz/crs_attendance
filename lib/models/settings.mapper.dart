// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class SettingsModelMapper extends ClassMapperBase<SettingsModel> {
  SettingsModelMapper._();

  static SettingsModelMapper? _instance;
  static SettingsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsModelMapper._());
      MapperContainer.globals.useAll([ThemeModeMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsModel';

  static ThemeMode _$themeMode(SettingsModel v) => v.themeMode;
  static const Field<SettingsModel, ThemeMode> _f$themeMode =
      Field('themeMode', _$themeMode, opt: true, def: ThemeMode.system);

  @override
  final MappableFields<SettingsModel> fields = const {
    #themeMode: _f$themeMode,
  };

  static SettingsModel _instantiate(DecodingData data) {
    return SettingsModel(data.dec(_f$themeMode));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsModel fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsModel>(map);
  }

  static SettingsModel fromJsonString(String json) {
    return ensureInitialized().decodeJson<SettingsModel>(json);
  }
}

mixin SettingsModelMappable {
  String toJsonString() {
    return SettingsModelMapper.ensureInitialized()
        .encodeJson<SettingsModel>(this as SettingsModel);
  }

  Map<String, dynamic> toJson() {
    return SettingsModelMapper.ensureInitialized()
        .encodeMap<SettingsModel>(this as SettingsModel);
  }

  SettingsModelCopyWith<SettingsModel, SettingsModel, SettingsModel>
      get copyWith => _SettingsModelCopyWithImpl(
          this as SettingsModel, $identity, $identity);
  @override
  String toString() {
    return SettingsModelMapper.ensureInitialized()
        .stringifyValue(this as SettingsModel);
  }

  @override
  bool operator ==(Object other) {
    return SettingsModelMapper.ensureInitialized()
        .equalsValue(this as SettingsModel, other);
  }

  @override
  int get hashCode {
    return SettingsModelMapper.ensureInitialized()
        .hashValue(this as SettingsModel);
  }
}

extension SettingsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsModel, $Out> {
  SettingsModelCopyWith<$R, SettingsModel, $Out> get $asSettingsModel =>
      $base.as((v, t, t2) => _SettingsModelCopyWithImpl(v, t, t2));
}

abstract class SettingsModelCopyWith<$R, $In extends SettingsModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({ThemeMode? themeMode});
  SettingsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsModel, $Out>
    implements SettingsModelCopyWith<$R, SettingsModel, $Out> {
  _SettingsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsModel> $mapper =
      SettingsModelMapper.ensureInitialized();
  @override
  $R call({ThemeMode? themeMode}) =>
      $apply(FieldCopyWithData({if (themeMode != null) #themeMode: themeMode}));
  @override
  SettingsModel $make(CopyWithData data) =>
      SettingsModel(data.get(#themeMode, or: $value.themeMode));

  @override
  SettingsModelCopyWith<$R2, SettingsModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsModelCopyWithImpl($value, $cast, t);
}
