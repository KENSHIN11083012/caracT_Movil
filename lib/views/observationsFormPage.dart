import 'package:flutter/material.dart';
import '../models/observationsInfo.dart';
import '../widgets/form/custom_text_field.dart';
import '../widgets/form/form_header.dart';
import '../widgets/layout/rounded_container.dart';
import '../widgets/form/continue_button.dart';

class ObservationsFormPage extends StatefulWidget {
  const ObservationsFormPage({super.key});

  @override
  State<ObservationsFormPage> createState() => _ObservationsFormPageState();
}

class _ObservationsFormPageState extends State<ObservationsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _observationsInfo = ObservationsInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: SafeArea(
        child: Column(
          children: [
            const FormHeader(
              title: 'Observaciones',
              currentStep: 9,
              totalSteps: 9,
            ),
            Expanded(
              child: RoundedContainer(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Caja informativa con descripción
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF607D8B).withValues(alpha: 0.1),
                                const Color(0xFF607D8B).withValues(alpha: 0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF607D8B).withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.comment_outlined,
                                size: 32,
                                color: Color(0xFF607D8B),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Observaciones Finales',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E2E2E),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Comparta comentarios adicionales o información relevante sobre la sede educativa',
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
                        CustomTextField(
                          label: 'Observaciones adicionales',
                          hintText: 'Agregue cualquier información adicional relevante',
                          onChanged: (value) => _observationsInfo.additionalObservations = value,
                          maxLines: 5,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Enviar Formulario'),
                        ),
                        const SizedBox(height: 16),
                        ContinueButton(
                          onPressed: () {},
                          showPrevious: true,
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
      
      // print(_observationsInfo.toJson()); // Comentado para producción
      
      // Mostrar diálogo de confirmación
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Formulario Enviado'),
          content: const Text('El formulario ha sido enviado exitosamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }
}
