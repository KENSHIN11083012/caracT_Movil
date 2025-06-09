import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/electricity_info.dart';
import '../models/survey_state.dart';
import '../widgets/layout/form_container.dart';

class ElectricityFormPage extends StatefulWidget {
  const ElectricityFormPage({super.key});

  @override
  State<ElectricityFormPage> createState() => _ElectricityFormPageState();
}

class _ElectricityFormPageState extends State<ElectricityFormPage> {
  final _formKey = GlobalKey<FormState>();
  late ElectricityInfo _electricityInfo;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    _electricityInfo = Provider.of<SurveyState>(context, listen: false).electricityInfo;
  }
  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Energía Eléctrica',
      currentStep: 5,
      onPrevious: () {
        // Guardar el estado actual
        Provider.of<SurveyState>(context, listen: false)
            .updateElectricityInfo(_electricityInfo);
        Navigator.pop(context);
      },      onNext: () {
        setState(() {
          _showErrors = true;
        });
        
        // Validar que las preguntas estén respondidas
        bool isValid = true;
        
        if (_electricityInfo.hasElectricService == null) {
          isValid = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Por favor, responda si la sede cuenta con servicio eléctrico'),
                ],
              ),
              backgroundColor: Colors.orange.shade600,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
        
        if (_electricityInfo.interestedInSolarPanels == null) {
          isValid = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Por favor, responda sobre el interés en paneles solares'),
                ],
              ),
              backgroundColor: Colors.orange.shade600,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
        
        if (isValid && (_formKey.currentState?.validate() ?? false)) {
          // Guardar el estado actual
          Provider.of<SurveyState>(context, listen: false)
              .updateElectricityInfo(_electricityInfo);
          Navigator.pushNamed(context, '/appliances');
        }
      },
      child: SingleChildScrollView(
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
                // Header con descripción
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.withValues(alpha: 0.1),
                        Colors.orange.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.electrical_services,
                        size: 32,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Servicio de Energía Eléctrica',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E2E2E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Información sobre el acceso y uso de energía eléctrica en la sede educativa',
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
                const SizedBox(height: 32),
                
                // Primera pregunta - Servicio de energía eléctrica
                _buildQuestionCard(
                  icon: Icons.power,
                  iconColor: Colors.green,
                  question: '¿La sede educativa cuenta con servicio de energía eléctrica?',
                  value: _electricityInfo.hasElectricService,
                  onChanged: (value) {
                    setState(() {
                      _electricityInfo.hasElectricService = value;
                    });
                  },
                  yesLabel: 'Sí, tiene servicio eléctrico',
                  noLabel: 'No, no tiene servicio eléctrico',
                ),

                const SizedBox(height: 24),
                
                // Segunda pregunta - Paneles solares
                _buildQuestionCard(
                  icon: Icons.solar_power,
                  iconColor: Colors.orange,
                  question: '¿Le interesaría instalar paneles solares en su vivienda?',
                  value: _electricityInfo.interestedInSolarPanels,
                  onChanged: (value) {
                    setState(() {
                      _electricityInfo.interestedInSolarPanels = value;
                    });
                  },
                  yesLabel: 'Sí, me interesa',
                  noLabel: 'No, no me interesa',
                ),
                
                const SizedBox(height: 80), // Espacio para los botones fijos
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard({
    required IconData icon,
    required Color iconColor,
    required String question,
    required bool? value,
    required Function(bool?) onChanged,
    required String yesLabel,
    required String noLabel,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la pregunta
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E2E2E),
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Opciones de respuesta
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Opción Sí
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: value == true 
                          ? Colors.green 
                          : Colors.grey.shade300,
                      width: value == true ? 2 : 1,
                    ),
                    color: value == true 
                        ? Colors.green.withValues(alpha: 0.05)
                        : Colors.white,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onChanged(true),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: value == true 
                                    ? Colors.green 
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              color: value == true 
                                  ? Colors.green 
                                  : Colors.white,
                            ),
                            child: value == true
                                ? const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.check_circle,
                            color: value == true 
                                ? Colors.green 
                                : Colors.grey.shade400,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              yesLabel,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: value == true 
                                    ? FontWeight.w600 
                                    : FontWeight.w500,
                                color: value == true 
                                    ? Colors.green.shade700 
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Opción No
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: value == false 
                          ? Colors.red 
                          : Colors.grey.shade300,
                      width: value == false ? 2 : 1,
                    ),
                    color: value == false 
                        ? Colors.red.withValues(alpha: 0.05)
                        : Colors.white,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onChanged(false),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: value == false 
                                    ? Colors.red 
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              color: value == false 
                                  ? Colors.red 
                                  : Colors.white,
                            ),
                            child: value == false
                                ? const Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.cancel,
                            color: value == false 
                                ? Colors.red 
                                : Colors.grey.shade400,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              noLabel,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: value == false 
                                    ? FontWeight.w600 
                                    : FontWeight.w500,
                                color: value == false 
                                    ? Colors.red.shade700 
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
