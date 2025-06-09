import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/observationsInfo.dart';
import '../models/survey_state.dart';
import '../widgets/layout/form_container.dart';

class ObservationsFormPage extends StatefulWidget {
  const ObservationsFormPage({super.key});

  @override
  State<ObservationsFormPage> createState() => _ObservationsFormPageState();
}

class _ObservationsFormPageState extends State<ObservationsFormPage> {
  final _formKey = GlobalKey<FormState>();  late ObservationsInfo _observationsInfo;
  final _observationsController = TextEditingController();
  static const bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    _observationsInfo = surveyState.observationsInfo;
    _observationsController.text = _observationsInfo.additionalObservations ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Observaciones',
      currentStep: 9,
      onPrevious: () => Navigator.pop(context),
      onNext: _submitForm,
      nextLabel: 'Finalizar',
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _showErrors 
                ? AutovalidateMode.always 
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Observaciones Adicionales',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                const Text(
                  'Registre cualquier observación adicional relevante para la caracterización de la sede educativa:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _observationsController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Incluya información sobre condiciones especiales, necesidades identificadas, proyectos en curso, o cualquier aspecto relevante no cubierto en las secciones anteriores...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    _observationsInfo.additionalObservations = value;
                  },
                ),
                const SizedBox(height: 32),
                
                // Mensaje de finalización
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green.shade600,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '¡Felicitaciones!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ha completado el formulario de caracterización educativa. Al finalizar, toda la información será guardada en el dispositivo.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Guardar la información de observaciones
    Provider.of<SurveyState>(context, listen: false)
        .updateObservationsInfo(_observationsInfo);
    
    // Mostrar mensaje de éxito y navegar a la pantalla principal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulario completado exitosamente'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 3),
      ),
    );
    
    // Navegar de vuelta al inicio o mostrar pantalla de resumen
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/',
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    _observationsController.dispose();
    super.dispose();
  }
}
