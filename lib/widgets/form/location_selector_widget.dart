import 'package:flutter/material.dart';
import '../../services/location_service.dart';

class LocationField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  const LocationField({
    super.key,
    required this.label,
    this.initialValue,
    required this.onChanged,
    this.validator,
  });
  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        final coordinates = LocationService.formatCoordinates(position);
        _controller.text = coordinates;
        widget.onChanged(coordinates);
      } else {
        setState(() {
          _errorMessage = 'No se pudo obtener la ubicación. Por favor, ingrese las coordenadas manualmente.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener la ubicación: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationPickerModal(
        onLocationSelected: (coordinates) {
          _controller.text = coordinates;
          widget.onChanged(coordinates);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ej: 4.6097, -74.0817',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.my_location, color: Color(0xFF4CAF50)),
                        onPressed: _getCurrentLocation,
                        tooltip: 'Obtener ubicación actual',
                      ),
                    IconButton(
                      icon: const Icon(Icons.map, color: Color(0xFF4CAF50)),
                      onPressed: _showLocationPicker,
                      tooltip: 'Seleccionar en mapa',
                    ),
                  ],
                ),
                helperText: _errorMessage ?? 'Formato: latitud, longitud',
                helperStyle: TextStyle(
                  color: _errorMessage != null ? Colors.red : Colors.grey.shade600,
                  fontSize: 12,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF4CAF50),
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.red.shade400,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.red.shade400,
                    width: 2.0,
                  ),
                ),
              ),
              validator: widget.validator ?? (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }

                final parts = value.split(',');
                if (parts.length != 2) {
                  return 'Formato inválido. Use: latitud, longitud';
                }

                try {
                  final lat = double.parse(parts[0].trim());
                  final lon = double.parse(parts[1].trim());

                  if (lat < -90 || lat > 90) {
                    return 'Latitud debe estar entre -90 y 90';
                  }
                  if (lon < -180 || lon > 180) {
                    return 'Longitud debe estar entre -180 y 180';
                  }
                } catch (e) {
                  return 'Las coordenadas deben ser números válidos';
                }

                return null;
              },
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class LocationPickerModal extends StatefulWidget {
  final void Function(String) onLocationSelected;

  const LocationPickerModal({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  void _selectCoordinates() {
    final lat = _latController.text.trim();
    final lon = _lonController.text.trim();
    
    if (lat.isNotEmpty && lon.isNotEmpty) {
      final coordinates = '$lat, $lon';
      widget.onLocationSelected(coordinates);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: GestureDetector(
          onTap: () {}, // Prevenir que el modal se cierre al tocar el contenido
          child: SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, -4),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Color(0xFF4CAF50),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Seleccionar Coordenadas',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E2E2E),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.grey.withValues(alpha: 0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Contenido
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextField(
                            controller: _latController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Latitud',
                              hintText: 'Ej: 4.6097',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.north),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _lonController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Longitud',
                              hintText: 'Ej: -74.0817',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.east),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    side: const BorderSide(color: Color(0xFF4CAF50)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      color: Color(0xFF4CAF50),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _selectCoordinates,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Seleccionar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}