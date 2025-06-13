import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/photographic_record_info.dart';
import '../models/survey_state.dart';
import '../widgets/layout/enhanced_form_container.dart';
import '../widgets/form/photo_capture_field.dart';
import '../utils/form_navigator.dart';
import 'observationsFormPage.dart';

class PhotographicRecordFormPage extends StatefulWidget {
  const PhotographicRecordFormPage({super.key});

  @override
  State<PhotographicRecordFormPage> createState() => _PhotographicRecordFormPageState();
}

class _PhotographicRecordFormPageState extends State<PhotographicRecordFormPage> {
  final _formKey = GlobalKey<FormState>();
  late PhotographicRecordInfo _photographicRecordInfo;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    _photographicRecordInfo = surveyState.photographicRecordInfo;
  }

  @override
  Widget build(BuildContext context) {
    return EnhancedFormContainer(
      title: 'Registro Fotográfico',
      subtitle: 'Documentación visual de la sede',
      currentStep: 8,
      onPrevious: () => FormNavigator.popForm(context),
      onNext: _submitForm,
      nextLabel: 'Siguiente',
      showPrevious: true,
      transitionType: FormTransitionType.slideScale,
      child: Form(
        key: _formKey,
        autovalidateMode: _showErrors 
            ? AutovalidateMode.always 
            : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Caja informativa con descripción
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF795548).withValues(alpha: 0.1),
                        const Color(0xFF795548).withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF795548).withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        size: 32,
                        color: Color(0xFF795548),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Registro Fotográfico',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E2E2E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Capture fotografías de los diferentes espacios de la sede educativa',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Campos de captura de fotos
                PhotoCaptureField(
                  label: 'Frente de la Escuela',
                  onImageSelected: (imagePath) {
                    setState(() {
                      _photographicRecordInfo.frontSchoolPhoto = imagePath;
                    });
                  },
                  imagePath: _photographicRecordInfo.frontSchoolPhoto,
                ),
                const SizedBox(height: 16),
                
                PhotoCaptureField(
                  label: 'Salones',
                  onImageSelected: (imagePath) {
                    setState(() {
                      _photographicRecordInfo.classroomsPhoto = imagePath;
                    });
                  },
                  imagePath: _photographicRecordInfo.classroomsPhoto,
                ),
                const SizedBox(height: 16),
                
                PhotoCaptureField(
                  label: 'Cocina',
                  onImageSelected: (imagePath) {
                    setState(() {
                      _photographicRecordInfo.kitchenPhoto = imagePath;
                    });
                  },
                  imagePath: _photographicRecordInfo.kitchenPhoto,
                ),
                const SizedBox(height: 16),
                
                PhotoCaptureField(
                  label: 'Comedor',
                  onImageSelected: (imagePath) {
                    setState(() {
                      _photographicRecordInfo.diningRoomPhoto = imagePath;
                    });
                  },
                  imagePath: _photographicRecordInfo.diningRoomPhoto,
                ),
                const SizedBox(height: 80), // Espacio para los botones fijos
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    setState(() {
      _showErrors = true;
    });

    // Guardar la información del registro fotográfico
    Provider.of<SurveyState>(context, listen: false)
        .updatePhotographicRecordInfo(_photographicRecordInfo);
    
    // Navegar a la página de observaciones usando el nuevo sistema
    FormNavigator.pushForm(
      context,
      const ObservationsFormPage(),
      type: FormTransitionType.slideScale,
      stepNumber: 9,
    );
  }
}
