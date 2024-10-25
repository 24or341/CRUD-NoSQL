// detalleEstudiante.dart

import 'package:flutter/material.dart';
import 'services/firebase_service.dart';

class StudentDetailsScreen extends StatelessWidget {
  final String studentId;
  final FirebaseService _firebaseService = FirebaseService();

  StudentDetailsScreen({required this.studentId});

  void _deleteStudent(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Estudiante'),
        content: Text('¿Estás seguro de que deseas eliminar este estudiante?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firebaseService.deleteStudent(studentId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Estudiante eliminado con éxito')),
                );
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al eliminar estudiante: $e')),
                );
              }
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Estudiante'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () =>
                _deleteStudent(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _firebaseService.getStudentById(studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error al cargar datos del estudiante'));
          }

          final student = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${student['name']}'),
                Text('Edad: ${student['age']}'),
                Text('Correo: ${student['email']}'),
                Text('Teléfono: ${student['phone']}'),
                Text('Dirección: ${student['address']}'),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('Editar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
