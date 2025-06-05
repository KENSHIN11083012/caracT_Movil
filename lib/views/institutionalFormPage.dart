import 'package:flutter/material.dart';
import '../models/institutionalInfo.dart';
import '../widgets/form/custom_text_field.dart';
import '../widgets/form/form_header.dart';
import '../widgets/layout/rounded_container.dart';
import '../widgets/form/continue_button.dart';
import '../widgets/form/location_field.dart';

class InstitutionalFormPage extends StatefulWidget {
  const InstitutionalFormPage({super.key});

  @override
  State<InstitutionalFormPage> createState() => _InstitutionalFormPageState();
}

class _InstitutionalFormPageState extends State<InstitutionalFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionalInfo = InstitutionalInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: SafeArea(
        child: Column(
          children: [
            const FormHeader(
              title: 'Formulario de Encuesta Educativa',
              currentStep: 2,
              totalSteps: 9,
            ),
            Expanded(
              child: RoundedContainer(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información Institucional',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: 'Nombre de la Institución Educativa - Principal',
                          onChanged: (value) => _institutionalInfo.institutionName = value,
                        ),
                        CustomTextField(
                          label: 'Nombre Sede Educativa',
                          onChanged: (value) => _institutionalInfo.educationalHeadquarters = value,
                        ),
                        CustomTextField(
                          label: 'Ubicación geográfica de la sede educativa (Coordenadas)',
                          hintText: 'Ej: 4.5709, -74.2973',
                          onChanged: (value) => _institutionalInfo.location = value,
                        ),
                        CustomTextField(
                          label: 'Nombre del Rector',
                          onChanged: (value) => _institutionalInfo.principalName = value,
                        ),
                        CustomTextField(
                          label: 'Contacto',
                          onChanged: (value) => _institutionalInfo.contact = value,
                        ),
                        CustomTextField(
                          label: 'Correo Electrónico',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => _institutionalInfo.email = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es requerido';
                            }
                            if (!value.contains('@')) {
                              return 'Ingrese un correo electrónico válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Anterior'),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF4CAF50),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _submitForm,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Continuar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar guardado local con Hive o SQLite
      print(_institutionalInfo.toJson()); // Para depuración
      
      // Navegar a la página de infraestructura
      Navigator.pushNamed(context, '/infrastructure');
    }
  }
}
