import 'package:flutter/material.dart';
import '../models/generalInfo.dart';
import '../widgets/form/custom_text_field.dart';
import '../widgets/form/custom_date_field.dart';
import '../widgets/form/form_header.dart';
import '../widgets/layout/rounded_container.dart';
import '../widgets/form/continue_button.dart';

class SurveyFormPage extends StatefulWidget {
  const SurveyFormPage({super.key});

  @override
  State<SurveyFormPage> createState() => _SurveyFormPageState();
}

class _SurveyFormPageState extends State<SurveyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _generalInfo = GeneralInfo();
  
  @override  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: SafeArea(
        child: Column(
          children: [
            const FormHeader(
              title: 'Formulario de Encuesta Educativa',
              currentStep: 1,
              totalSteps: 9,
            ),
            Expanded(
              child: RoundedContainer(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información General',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomDateField(
                          label: 'Fecha de Diligenciamiento',
                          initialDate: _generalInfo.date,
                          onDateSelected: (date) {
                            setState(() {
                              _generalInfo.date = date;
                            });
                          },
                        ),
                        CustomTextField(
                          label: 'Departamento',
                          onChanged: (value) => _generalInfo.department = value,
                        ),
                        CustomTextField(
                          label: 'Municipio',
                          onChanged: (value) => _generalInfo.municipality = value,
                        ),
                        CustomTextField(
                          label: 'Corregimiento',
                          onChanged: (value) => _generalInfo.district = value,
                        ),
                        CustomTextField(
                          label: 'Vereda',
                          onChanged: (value) => _generalInfo.village = value,
                        ),
                        CustomTextField(
                          label: 'Nombre del Entrevistado/a y cargo',
                          onChanged: (value) => _generalInfo.intervieweeName = value,
                        ),
                        CustomTextField(
                          label: 'Contacto',
                          onChanged: (value) => _generalInfo.contact = value,
                        ),
                        const SizedBox(height: 20),                        ContinueButton(
                          onPressed: _submitForm,
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
  }  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar guardado local con Hive o SQLite
      print(_generalInfo.toJson()); // Para depuración
      
      // Navegar a la página de información institucional
      Navigator.pushNamed(context, '/institutional');
    }
  }
}