import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../config/theme.dart';
import '../../services/location_service.dart';

class LocationField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final void Function(String) onChanged;

  const LocationField({
    super.key,
    required this.label,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final _controller = TextEditingController();
  bool _isLoading = false;

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
    });

    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        final coordinates = LocationService.formatCoordinates(position);
        _controller.text = coordinates;
        widget.onChanged(coordinates);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo obtener la ubicación. Por favor, ingrésela manualmente.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controller,
        decoration: AppTheme.inputDecoration.copyWith(
          labelText: widget.label,
          hintText: 'Ej: 4.5709, -74.2973',
          suffixIcon: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: _getCurrentLocation,
                  tooltip: 'Obtener ubicación actual',
                ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es requerido';
          }
          // Validar formato de coordenadas (básico)
          final coordinates = value.split(',');
          if (coordinates.length != 2) {
            return 'Formato inválido. Use: latitud, longitud';
          }
          return null;
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}
