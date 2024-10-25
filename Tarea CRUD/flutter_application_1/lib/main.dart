import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/firebase_service.dart';
import 'añadirEstudiante.dart';
import 'detalleEstudiante.dart';
import 'editarEstudiante.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Estudiantes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  void _deleteStudent(BuildContext context, String studentId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Estudiante',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('¿Estás seguro de que deseas eliminar este estudiante?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firebaseService.deleteStudent(studentId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Estudiante eliminado con éxito')),
                );
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al eliminar estudiante: $e')),
                );
              }
            },
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Estudiantes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        future: _firebaseService.getAllStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error al cargar estudiantes: ${snapshot.error}'));
          }

          final students = snapshot.data ?? [];
          if (students.isEmpty) {
            return Center(child: Text('No hay estudiantes disponibles'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index].data();
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4,
                child: ListTile(
                  title: Text(student['name'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Email: ${student['email']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditStudentScreen(
                          studentId: students[index].id,
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteStudent(context, students[index].id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
