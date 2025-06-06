import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/electricity_info.dart';
import '../models/survey_state.dart';
import '../widgets/form/form_navigation_buttons.dart';
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
    // Inicializar con valores por defecto
    _electricityInfo = ElectricityInfo(
      hasElectricService: false,
      interestedInSolarPanels: false,
    );
    // Obtener datos del Provider
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    if (surveyState.electricityInfo != null) {
      _electricityInfo = surveyState.electricityInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Energía Eléctrica',
      currentStep: 5,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: const Text(
                                '¿Tiene servicio de energía eléctrica?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: _electricityInfo.hasElectricService ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _electricityInfo.hasElectricService = value;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text(
                                '¿Está interesado en paneles solares?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: _electricityInfo.interestedInSolarPanels ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _electricityInfo.interestedInSolarPanels = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
    if (_formKey.currentState?.validate() ?? false) {
      // Guardar en el Provider
      Provider.of<SurveyState>(context, listen: false).electricityInfo = _electricityInfo;
      
      // Navegar a la siguiente página
      Navigator.pushNamed(context, '/appliances');
    } else {
      setState(() {
        _showErrors = true;
      });
    }
  }
}
