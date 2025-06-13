import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/access_route_info.dart';
import '../models/survey_state.dart';
import '../widgets/layout/enhanced_form_container.dart';
import '../utils/form_navigator.dart';
import 'photographic_record_form_page.dart';

class AccessRouteFormPage extends StatefulWidget {
  const AccessRouteFormPage({super.key});

  @override
  State<AccessRouteFormPage> createState() => _AccessRouteFormPageState();
}

class _AccessRouteFormPageState extends State<AccessRouteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late AccessRouteInfo _accessRouteInfo;
  final _routeController = TextEditingController();
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    _accessRouteInfo = surveyState.accessRouteInfo;
    _routeController.text = _accessRouteInfo.routeDescription ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return EnhancedFormContainer(
      title: 'Ruta de Acceso',
      subtitle: 'Información sobre acceso a la sede',
      currentStep: 7,
      onPrevious: () => FormNavigator.popForm(context),
      onNext: _submitForm,
      nextLabel: 'Siguiente',
      showPrevious: true,
      transitionType: FormTransitionType.slideScale,
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
                // Caja informativa con descripción
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF9C27B0).withValues(alpha: 0.1),
                        const Color(0xFF9C27B0).withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF9C27B0).withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.route_outlined,
                        size: 32,
                        color: Color(0xFF9C27B0),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Ruta de Acceso',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E2E2E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Descripción detallada de cómo llegar hasta la sede educativa',
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
                const Text(
                  'Describa la ruta para llegar hasta la sede educativa:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _routeController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: 'Incluya medios de transporte, tiempos, lugares de referencia, entre otros aspectos relevantes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, describa la ruta de acceso';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _accessRouteInfo.routeDescription = value;
                  },
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
    
    if (_formKey.currentState!.validate()) {
      Provider.of<SurveyState>(context, listen: false)
          .updateAccessRouteInfo(_accessRouteInfo);
      
      // Usar el nuevo sistema de navegación con transiciones suaves
      FormNavigator.pushForm(
        context,
        const PhotographicRecordFormPage(),
        type: FormTransitionType.slideScale,
        stepNumber: 8,
      );
    }
  }

  @override
  void dispose() {
    _routeController.dispose();
    super.dispose();
  }
}
