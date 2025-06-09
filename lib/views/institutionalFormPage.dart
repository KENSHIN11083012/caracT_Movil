import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/institutionalInfo.dart';
import '../models/survey_state.dart';
import '../widgets/form/custom_text_field.dart';
import '../widgets/form/location_field.dart';
import '../widgets/form/form_navigation_buttons.dart';
import '../widgets/layout/form_container.dart';

class InstitutionalFormPage extends StatefulWidget {
  const InstitutionalFormPage({super.key});

  @override
  State<InstitutionalFormPage> createState() => _InstitutionalFormPageState();
}

class _InstitutionalFormPageState extends State<InstitutionalFormPage> {
  final _formKey = GlobalKey<FormState>();
  late InstitutionalInfo _institutionalInfo;
  bool _showErrors = false;
  
  // Agregar controllers
  final _institutionNameController = TextEditingController();
  final _headquartersController = TextEditingController();
  final _principalNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    _institutionalInfo = surveyState.institutionalInfo;
    
    // Inicializar controllers
    _institutionNameController.text = _institutionalInfo.institutionName ?? '';
    _headquartersController.text = _institutionalInfo.educationalHeadquarters ?? '';
    _principalNameController.text = _institutionalInfo.principalName ?? '';
    _contactController.text = _institutionalInfo.contact ?? '';
    _emailController.text = _institutionalInfo.email ?? '';
  }

  @override
  void dispose() {
    _institutionNameController.dispose();
    _headquartersController.dispose();
    _principalNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Información Institucional',
      currentStep: 2,
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              autovalidateMode: _showErrors 
                  ? AutovalidateMode.always 
                  : AutovalidateMode.disabled,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Text(
                    'Información Institucional',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  
                  CustomTextField(
                    label: 'Nombre de la Institución Educativa - Principal',
                    controller: _institutionNameController,
                    onChanged: (value) => _institutionalInfo.institutionName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    label: 'Nombre Sede Educativa',
                    controller: _headquartersController,
                    onChanged: (value) => _institutionalInfo.educationalHeadquarters = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  LocationField(
                    label: 'Ubicación geográfica de la sede educativa (Coordenadas)',
                    initialValue: _institutionalInfo.location,
                    onChanged: (value) => _institutionalInfo.location = value,
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    label: 'Nombre del Rector',
                    controller: _principalNameController,
                    onChanged: (value) => _institutionalInfo.principalName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    label: 'Contacto',
                    keyboardType: TextInputType.phone,
                    controller: _contactController,
                    onChanged: (value) => _institutionalInfo.contact = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    label: 'Correo Electrónico',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      if (!value.contains('@')) {
                        return 'Ingrese un correo electrónico válido';
                      }
                      return null;
                    },
                    onChanged: (value) => _institutionalInfo.email = value,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          FormNavigationButtons(
            onPrevious: () => Navigator.pop(context),
            onNext: _submitForm,
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    setState(() {
      _showErrors = true;
    });

    if (_formKey.currentState!.validate()) {
      Provider.of<SurveyState>(context, listen: false)
          .updateInstitutionalInfo(_institutionalInfo);
      Navigator.pushNamed(context, '/coverage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos requeridos'),
          backgroundColor: Color(0xFFD32F2F),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }
}
