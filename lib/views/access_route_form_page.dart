import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/access_route_info.dart';
import '../models/survey_state.dart';
import '../widgets/form/form_navigation_buttons.dart';
import '../widgets/layout/form_container.dart';

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
    return FormContainer(
      title: 'Ruta de Acceso',
      currentStep: 7,
      child: Column(
        children: [
          Expanded(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormNavigationButtons(
                  onPrevious: () => Navigator.pop(context),
                  onNext: _submitForm,
                ),
              ),
            ),
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
          .updateAccessRouteInfo(_accessRouteInfo);
      Navigator.pushNamed(context, '/observations'); // Corregido de '/appliances' a '/observations'
    }
  }

  @override
  void dispose() {
    _routeController.dispose();
    super.dispose();
  }
}
