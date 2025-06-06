import 'package:flutter/material.dart';
import '../models/infrastructureInfo.dart';
import '../services/storage_service.dart';
import '../widgets/form/form_navigation_buttons.dart';
import '../widgets/layout/form_container.dart';

class InfrastructureFormPage extends StatefulWidget {
  const InfrastructureFormPage({super.key});

  @override
  State<InfrastructureFormPage> createState() => _InfrastructureFormPageState();
}

class _InfrastructureFormPageState extends State<InfrastructureFormPage> {
  final _formKey = GlobalKey<FormState>();
  late InfrastructureInfo infrastructureInfo;
  final TextEditingController _proyectosController = TextEditingController();
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    infrastructureInfo = InfrastructureInfo();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    try {
      final savedData = await StorageService.getInfrastructureInfo();
      if (savedData != null) {
        setState(() {
          infrastructureInfo = savedData;
          _proyectosController.text = savedData.proyectosInfraestructura;
        });
      }
    } catch (e) {
      print('Error al cargar datos: $e');
    }
  }

  Future<void> _saveData() async {
    setState(() {
      _showErrors = true;
    });

    if (_formKey.currentState!.validate()) {
      infrastructureInfo.proyectosInfraestructura = _proyectosController.text;
      try {
        await StorageService.saveInfrastructureInfo(infrastructureInfo);
        if (mounted) {
          Navigator.pushNamed(context, '/electricity');
        }
      } catch (e) {
        print('Error al guardar datos: $e');
      }
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

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Infraestructura',
      currentStep: 4,
      child: Column(
        children: [
          Expanded(
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
                      const Text(
                        'Infraestructura',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Marque si la sede cuenta con los siguientes espacios:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CheckboxListTile(
                              title: const Text('Salones'),
                              value: infrastructureInfo.hasSalones,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasSalones = value ?? false;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            CheckboxListTile(
                              title: const Text('Comedor'),
                              value: infrastructureInfo.hasComedor,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasComedor = value ?? false;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            CheckboxListTile(
                              title: const Text('Cocina'),
                              value: infrastructureInfo.hasCocina,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasCocina = value ?? false;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            CheckboxListTile(
                              title: const Text('Salón para reuniones'),
                              value: infrastructureInfo.hasSalonReuniones,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasSalonReuniones = value ?? false;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            CheckboxListTile(
                              title: const Text('Habitaciones'),
                              value: infrastructureInfo.hasHabitaciones,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasHabitaciones = value ?? false;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            CheckboxListTile(
                              title: const Text('Baños'),
                              value: infrastructureInfo.hasBanos,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasBanos = value ?? false;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            CheckboxListTile(
                              title: const Text('Otro'),
                              value: infrastructureInfo.hasOtros,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.hasOtros = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      
                      const Text(
                        'Mencione si existen proyectos de infraestructura que se estén ejecutando en la sede educativa:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 150),
                        child: TextFormField(
                          controller: _proyectosController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: 'Canchas, baños, salones, comedor, cocina, etc. Indique qué entidad los está realizando.',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      
                      const Text(
                        'El predio donde se encuentra la sede educativa, es de propiedad de:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile<String>(
                              title: const Text('Municipio'),
                              value: 'Municipio',
                              groupValue: infrastructureInfo.propiedadPredio,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.propiedadPredio = value!;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            RadioListTile<String>(
                              title: const Text('Junta de acción comunal'),
                              value: 'Junta de acción comunal',
                              groupValue: infrastructureInfo.propiedadPredio,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.propiedadPredio = value!;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            RadioListTile<String>(
                              title: const Text('Privado'),
                              value: 'Privado',
                              groupValue: infrastructureInfo.propiedadPredio,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.propiedadPredio = value!;
                                });
                              },
                            ),
                            const Divider(height: 1),
                            RadioListTile<String>(
                              title: const Text('Otro'),
                              value: 'Otro',
                              groupValue: infrastructureInfo.propiedadPredio,
                              onChanged: (value) {
                                setState(() {
                                  infrastructureInfo.propiedadPredio = value!;
                                });
                              },
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
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormNavigationButtons(
                onPrevious: () => Navigator.pop(context),
                onNext: _saveData,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _proyectosController.dispose();
    super.dispose();
  }
}
