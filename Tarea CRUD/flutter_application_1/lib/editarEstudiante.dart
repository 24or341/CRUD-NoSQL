import 'package:flutter/material.dart';
import 'services/firebase_service.dart';

class EditStudentScreen extends StatefulWidget {
  final String studentId;

  EditStudentScreen({required this.studentId});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  void _loadStudentData() async {
    var studentData = await _firebaseService.getStudentById(widget.studentId);
    if (studentData != null) {
      _nameController.text = studentData['name'];
      _ageController.text = studentData['age'].toString();
      _emailController.text = studentData['email'];
      _phoneController.text = studentData['phone'];
      _addressController.text = studentData['address'];
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _updateStudent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _firebaseService.updateStudent(
          widget.studentId,
          {
            'name': _nameController.text,
            'age': int.parse(_ageController.text),
            'email': _emailController.text,
            'phone': _phoneController.text,
            'address': _addressController.text,
          },
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Estudiante actualizado con éxito')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar estudiante: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Estudiante'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Edad',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return 'Por favor ingrese una edad válida';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Por favor ingrese un correo válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un número de teléfono';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Dirección',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una dirección';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateStudent,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                      child: Text('Actualizar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
