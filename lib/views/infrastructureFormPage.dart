import 'package:flutter/material.dart';
import '../models/infrastructureInfo.dart';
import '../widgets/form/form_header.dart';
import '../widgets/form/continue_button.dart';
import '../widgets/form/custom_number_field.dart';
import '../widgets/form/custom_dropdown_field.dart';
import '../widgets/layout/rounded_container.dart';

class InfrastructureFormPage extends StatefulWidget {
  const InfrastructureFormPage({super.key});

  @override
  State<InfrastructureFormPage> createState() => _InfrastructureFormPageState();
}

class _InfrastructureFormPageState extends State<InfrastructureFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _infrastructureInfo = InfrastructureInfo();

  final List<String> _buildingTypes = [
    'Concreto',
    'Madera',
    'Mixto',
    'Otro',
  ];

  final List<String> _yesNoOptions = [
    'Sí',
    'No',
  ];

  final List<String> _waterSources = [
    'Acueducto',
    'Pozo',
    'Río/Quebrada',
    'Otro',
  ];

  final List<String> _electricitySources = [
    'Red Eléctrica',
    'Planta Solar',
    'Generador',
    'No tiene',
  ];

  final List<String> _internetTypes = [
    'Fibra Óptica',
    'Satelital',
    'No tiene',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: SafeArea(
        child: Column(
          children: [
            const FormHeader(
              title: 'Formulario de Encuesta Educativa',
              currentStep: 3,
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
                          'Infraestructura',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          label: 'Tipo de Construcción',
                          value: _infrastructureInfo.buildingType,
                          items: _buildingTypes,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.buildingType = value;
                          }),
                        ),
                        CustomNumberField(
                          label: 'Número de Aulas',
                          initialValue: _infrastructureInfo.classroomsCount,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.classroomsCount = value;
                          }),
                        ),
                        CustomNumberField(
                          label: 'Número de Baños',
                          initialValue: _infrastructureInfo.bathroomsCount,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.bathroomsCount = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: 'Fuente de Agua',
                          value: _infrastructureInfo.waterSource,
                          items: _waterSources,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.waterSource = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: 'Fuente de Electricidad',
                          value: _infrastructureInfo.electricitySource,
                          items: _electricitySources,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.electricitySource = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: 'Acceso a Internet',
                          value: _infrastructureInfo.internetAccess,
                          items: _internetTypes,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.internetAccess = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: '¿Cuenta con Instalaciones Deportivas?',
                          value: _infrastructureInfo.sportsFacilities,
                          items: _yesNoOptions,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.sportsFacilities = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: '¿Cuenta con Laboratorio?',
                          value: _infrastructureInfo.laboratory,
                          items: _yesNoOptions,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.laboratory = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: '¿Cuenta con Sala de Informática?',
                          value: _infrastructureInfo.computerRoom,
                          items: _yesNoOptions,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.computerRoom = value;
                          }),
                        ),
                        CustomDropdownField(
                          label: '¿Cuenta con Biblioteca?',
                          value: _infrastructureInfo.library,
                          items: _yesNoOptions,
                          onChanged: (value) => setState(() {
                            _infrastructureInfo.library = value;
                          }),
                        ),
                        const SizedBox(height: 20),
                        ContinueButton(
                          showPrevious: true,
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
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar guardado local con Hive o SQLite
      print(_infrastructureInfo.toJson()); // Para depuración
      
      // TODO: Navegar a la siguiente página cuando esté creada
      // Navigator.pushNamed(context, '/next-page');
    }
  }
}
