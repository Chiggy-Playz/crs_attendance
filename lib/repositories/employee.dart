import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crs_attendance/models/employee.dart';

class EmployeeRepository {
  final FirebaseFirestore _firestore;

  EmployeeRepository(this._firestore);

  CollectionReference get _employeesCollection =>
      _firestore.collection('employees');

  Stream<List<EmployeeModel>> watchEmployees() {
    return _employeesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return EmployeeModel.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  Future<EmployeeModel?> getEmployee(String id) async {
    final doc = await _employeesCollection.doc(id).get();
    if (!doc.exists) return null;

    final data = doc.data() as Map<String, dynamic>;
    return EmployeeModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  Future<void> addEmployee(EmployeeModel employee) {
    return _employeesCollection.add(employee.toJson()..remove('id'));
  }

  Future<void> updateEmployee(EmployeeModel employee) {
    return _employeesCollection.doc(employee.id).update(employee.toJson());
  }

  Future<void> deleteEmployee(EmployeeModel employee) {
    return _employeesCollection.doc(employee.id).delete();
  }
}
