import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createStudent(
      String name, int age, String email, String phone, String address) async {
    try {
      final docStudent = _firestore.collection('students').doc();
      final studentId = docStudent.id;

      await docStudent.set({
        'studentId': studentId,
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        'address': address,
        'enrolledCourses': [],
      });
      print('Estudiante creado con éxito');
    } catch (e) {
      print('Error al crear estudiante: $e');
    }
  }

  Future<Map<String, dynamic>?> getStudentById(String studentId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection('students').doc(studentId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        print('Estudiante no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener estudiante: $e');
      return null;
    }
  }

  Future<void> updateStudent(
      String studentId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore
          .collection('students')
          .doc(studentId)
          .update(updatedData);
      print('Estudiante actualizado con éxito');
    } catch (e) {
      print('Error al actualizar estudiante: $e');
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await _firestore.collection('students').doc(studentId).delete();
      print('Estudiante eliminado con éxito');
    } catch (e) {
      print('Error al eliminar estudiante: $e');
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllStudents() async {
    try {
      final querySnapshot = await _firestore.collection('students').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error al obtener la lista de estudiantes: $e');
      return [];
    }
  }
}
