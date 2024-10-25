import 'package:flutter/material.dart';
import 'services/firebase_service.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _firebaseService.createStudent(
          _nameController.text,
          int.parse(_ageController.text),
          _emailController.text,
          _phoneController.text,
          _addressController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Estudiante agregado con éxito')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar estudiante: $e')),
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
        title: Text('Agregar Estudiante'),
      ),
      body: Padding(
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
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveStudent,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                      child: Text('Guardar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
