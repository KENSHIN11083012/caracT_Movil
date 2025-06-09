import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coverageInfo.dart';
import '../models/survey_state.dart';
import '../widgets/form/custom_number_field.dart';
import '../widgets/form/form_navigation_buttons.dart';
import '../widgets/layout/form_container.dart';

class CoverageFormPage extends StatefulWidget {
  const CoverageFormPage({super.key});

  @override
  State<CoverageFormPage> createState() => _CoverageFormPageState();
}

class _CoverageFormPageState extends State<CoverageFormPage> {
  final _formKey = GlobalKey<FormState>();
  late CoverageInfo _coverageInfo;
  final _educationalLevelsController = TextEditingController();
  bool _showErrors = false;

  final List<String> _availableLevels = [
    'Preescolar',
    'Primaria',
    'Secundaria',
  ];

  List<String> _selectedLevels = [];

  @override
  void initState() {
    super.initState();
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    _coverageInfo = surveyState.coverageInfo;
    _selectedLevels = _coverageInfo.educationalLevels ?? [];
    _educationalLevelsController.text = _selectedLevels.join(', ');
  }

  @override
  void dispose() {
    _educationalLevelsController.dispose();
    super.dispose();
  }

  void _updateSelectedLevels(List<String> levels) {
    setState(() {
      _selectedLevels = levels;
      _coverageInfo.educationalLevels = levels;
      _educationalLevelsController.text = levels.join(', ');
    });
  }

  void _showLevelsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Niveles educativos'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: _availableLevels.map((level) {
                    return CheckboxListTile(
                      title: Text(level),
                      value: _selectedLevels.contains(level),
                      onChanged: (bool? selected) {
                        setState(() {
                          if (selected ?? false) {
                            if (!_selectedLevels.contains(level)) {
                              _selectedLevels.add(level);
                            }
                          } else {
                            _selectedLevels.remove(level);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    _updateSelectedLevels(_selectedLevels);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Cobertura',
      currentStep: 3,
      child: Column(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: _showErrors 
                ? AutovalidateMode.always 
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Cobertura',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                CustomNumberField(
                  label: 'N° alumnos',
                  initialValue: _coverageInfo.totalStudents,
                  onChanged: (value) => _coverageInfo.totalStudents = value,
                ),
                const SizedBox(height: 16),
                
                CustomNumberField(
                  label: 'N° niños',
                  initialValue: _coverageInfo.boysCount,
                  onChanged: (value) => _coverageInfo.boysCount = value,
                ),
                const SizedBox(height: 16),
                
                CustomNumberField(
                  label: 'N° niñas',
                  initialValue: _coverageInfo.girlsCount,
                  onChanged: (value) => _coverageInfo.girlsCount = value,
                ),
                const SizedBox(height: 16),
                
                CustomNumberField(
                  label: 'N° Docentes',
                  initialValue: _coverageInfo.teachersCount,
                  onChanged: (value) => _coverageInfo.teachersCount = value,
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _educationalLevelsController,
                  decoration: InputDecoration(
                    labelText: 'Niveles educativos ofertados',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: _showLevelsDialog,
                    ),
                  ),
                  readOnly: true,
                  onTap: _showLevelsDialog,
                  validator: (value) {
                    if (_selectedLevels.isEmpty) {
                      return 'Seleccione al menos un nivel educativo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
              ],
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormNavigationButtons(
                onPrevious: () => Navigator.pop(context),
                onNext: _submitForm,
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
      // Validaciones adicionales
      if (_coverageInfo.totalStudents != (_coverageInfo.boysCount ?? 0) + (_coverageInfo.girlsCount ?? 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El número total de alumnos debe ser igual a la suma de niños y niñas'),
            backgroundColor: Color(0xFFD32F2F),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
          ),
        );
        return;
      }

      Provider.of<SurveyState>(context, listen: false)
          .updateCoverageInfo(_coverageInfo);
      Navigator.pushNamed(context, '/infrastructure');
    }
  }
}
