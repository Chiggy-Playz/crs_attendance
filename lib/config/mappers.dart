import 'package:dart_mappable/dart_mappable.dart';

class LocalDateTimeMapper extends SimpleMapper<DateTime> {
  const LocalDateTimeMapper();

  @override
  DateTime decode(dynamic value) {
    if (value is String) {
      return DateTime.parse(value).toLocal();
    } else {
      throw Exception();
    }
  }

  @override
  Object encode(DateTime self) {
    return self.toUtc().toIso8601String();
  }
}
