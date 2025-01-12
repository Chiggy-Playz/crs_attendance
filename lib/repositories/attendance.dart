import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crs_attendance/models/attendance.dart';

class AttendanceRepository {
  final FirebaseFirestore _firestore;

  AttendanceRepository(this._firestore);

  CollectionReference get _attendanceCollection =>
      _firestore.collection('attendance');

  Stream<List<AttendanceModel>> watchAttendance() {
    return _attendanceCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return AttendanceModel.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  Future<List<AttendanceModel>> getAttendanceByDate(DateTime date) async {
    // Filter where date is equal to the given date.toIso8601String()
    final snapshot = await _attendanceCollection
        .where('date', isEqualTo: date.toUtc().toIso8601String())
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return AttendanceModel.fromJson({
        ...data,
        'id': doc.id,
      });
    }).toList();
  }

  Future<void> updateAttendance(AttendanceModel attendance) {
    return _attendanceCollection.doc(attendance.id).update(attendance.toJson());
  }

  Future<void> updateAttendances(List<AttendanceModel> attendances) {
    final batch = _firestore.batch();
    for (final attendance in attendances) {
      if (attendance.status == AttendanceStatus.choose) {
        batch.delete(_attendanceCollection.doc(attendance.id));
        continue;
      }
      batch.set(_attendanceCollection.doc(attendance.id), attendance.toJson());
    }
    return batch.commit();
  }
}
