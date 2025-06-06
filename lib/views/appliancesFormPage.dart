import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appliances_info.dart';
import '../models/survey_state.dart';
import '../widgets/form/form_navigation_buttons.dart';
import '../widgets/layout/form_container.dart';

class AppliancesFormPage extends StatefulWidget {
  const AppliancesFormPage({super.key});

  @override
  State<AppliancesFormPage> createState() => _AppliancesFormPageState();
}

class _AppliancesFormPageState extends State<AppliancesFormPage> {
  late AppliancesInfo _appliancesInfo;

  @override
  void initState() {
    super.initState();
    final surveyState = Provider.of<SurveyState>(context, listen: false);
    _appliancesInfo = surveyState.appliancesInfo;
  }

  Widget _buildApplianceItem(ApplianceItem appliance) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              appliance.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Campo de cantidad
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: appliance.quantity.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        appliance.quantity = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Radio buttons de Sí/No
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('¿En uso?', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    appliance.isInUse = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: appliance.isInUse ? Colors.green.shade50 : null,
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: appliance.isInUse,
                                        onChanged: (value) {
                                          setState(() {
                                            appliance.isInUse = value!;
                                          });
                                        },
                                      ),
                                      const Text('Sí', style: TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    appliance.isInUse = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: !appliance.isInUse ? Colors.grey.shade50 : null,
                                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<bool>(
                                        value: false,
                                        groupValue: appliance.isInUse,
                                        onChanged: (value) {
                                          setState(() {
                                            appliance.isInUse = value!;
                                          });
                                        },
                                      ),
                                      const Text('No', style: TextStyle(fontSize: 13)),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Guardar los datos sin validación de formulario ya que no tenemos campos requeridos
    Provider.of<SurveyState>(context, listen: false)
        .updateAppliancesInfo(_appliancesInfo);
    Navigator.pushNamed(context, '/access-route');
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Electrodomésticos',
      currentStep: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Contenido del formulario
          ...List.generate(_appliancesInfo.appliances.length, 
            (index) => _buildApplianceItem(_appliancesInfo.appliances[index])
          ),
          const SizedBox(height: 16),
          
          ElevatedButton.icon(
            onPressed: _showAddApplianceDialog,
            icon: const Icon(Icons.add),
            label: const Text('Agregar otro electrodoméstico'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          
          // Botones de navegación
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: FormNavigationButtons(
              onPrevious: () => Navigator.pop(context),
              onNext: _submitForm,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddApplianceDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo Electrodoméstico'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nombre del electrodoméstico',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _appliancesInfo.appliances.add(
                    ApplianceItem(name: controller.text),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
