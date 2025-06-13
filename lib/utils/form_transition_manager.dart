import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Gestiona el estado y configuración de las transiciones entre formularios
class FormTransitionManager extends ChangeNotifier {
  static final FormTransitionManager _instance = FormTransitionManager._internal();
  factory FormTransitionManager() => _instance;
  FormTransitionManager._internal();

  FormTransitionType _defaultTransitionType = FormTransitionType.slideScale;
  Duration _transitionDuration = const Duration(milliseconds: 300);
  Curve _transitionCurve = Curves.easeInOutCubic;
  bool _hapticsEnabled = true;
  bool _soundEnabled = false;
  double _transitionIntensity = 1.0; // 0.5 - 2.0

  // Configuración de transiciones
  FormTransitionType get defaultTransitionType => _defaultTransitionType;
  Duration get transitionDuration => _transitionDuration;
  Curve get transitionCurve => _transitionCurve;
  bool get hapticsEnabled => _hapticsEnabled;
  bool get soundEnabled => _soundEnabled;
  double get transitionIntensity => _transitionIntensity;

  // Estadísticas de uso
  final Map<FormTransitionType, int> _transitionUsageCount = {};
  int _totalTransitions = 0;

  /// Configura el tipo de transición por defecto
  void setDefaultTransitionType(FormTransitionType type) {
    if (_defaultTransitionType != type) {
      _defaultTransitionType = type;
      notifyListeners();
    }
  }

  /// Configura la duración de las transiciones
  void setTransitionDuration(Duration duration) {
    if (_transitionDuration != duration) {
      _transitionDuration = duration;
      notifyListeners();
    }
  }

  /// Configura la curva de animación
  void setTransitionCurve(Curve curve) {
    if (_transitionCurve != curve) {
      _transitionCurve = curve;
      notifyListeners();
    }
  }

  /// Habilita/deshabilita el feedback háptico
  void setHapticsEnabled(bool enabled) {
    if (_hapticsEnabled != enabled) {
      _hapticsEnabled = enabled;
      notifyListeners();
    }
  }

  /// Habilita/deshabilita los sonidos de transición
  void setSoundEnabled(bool enabled) {
    if (_soundEnabled != enabled) {
      _soundEnabled = enabled;
      notifyListeners();
    }
  }

  /// Configura la intensidad de las transiciones (0.5 - 2.0)
  void setTransitionIntensity(double intensity) {
    final clampedIntensity = intensity.clamp(0.5, 2.0);
    if (_transitionIntensity != clampedIntensity) {
      _transitionIntensity = clampedIntensity;
      notifyListeners();
    }
  }

  /// Registra el uso de una transición
  void recordTransitionUsage(FormTransitionType type) {
    _transitionUsageCount[type] = (_transitionUsageCount[type] ?? 0) + 1;
    _totalTransitions++;
  }

  /// Obtiene estadísticas de uso de transiciones
  Map<FormTransitionType, double> getTransitionUsageStats() {
    if (_totalTransitions == 0) return {};
    
    return _transitionUsageCount.map(
      (type, count) => MapEntry(type, count / _totalTransitions),
    );
  }

  /// Ejecuta feedback háptico según el tipo de transición
  void performHapticFeedback(FormTransitionType type) {
    if (!_hapticsEnabled) return;

    switch (type) {
      case FormTransitionType.slide:
        HapticFeedback.lightImpact();
        break;
      case FormTransitionType.slideScale:
        HapticFeedback.mediumImpact();
        break;
      case FormTransitionType.fadeSlide:
        HapticFeedback.selectionClick();
        break;
      case FormTransitionType.layered:
        HapticFeedback.heavyImpact();
        break;
    }
  }

  /// Obtiene la duración ajustada por intensidad
  Duration getAdjustedDuration() {
    return Duration(
      milliseconds: (_transitionDuration.inMilliseconds / _transitionIntensity).round(),
    );
  }

  /// Restablece las configuraciones a valores por defecto
  void resetToDefaults() {
    _defaultTransitionType = FormTransitionType.slideScale;
    _transitionDuration = const Duration(milliseconds: 300);
    _transitionCurve = Curves.easeInOutCubic;
    _hapticsEnabled = true;
    _soundEnabled = false;
    _transitionIntensity = 1.0;
    notifyListeners();
  }

  /// Configuración automática basada en el rendimiento del dispositivo
  void autoConfigureForDevice() {
    // En un entorno real, aquí se evaluaría el rendimiento del dispositivo
    // Por ahora, usamos configuraciones conservadoras
    
    if (kDebugMode) {
      // En modo debug, usar transiciones más rápidas
      setTransitionDuration(const Duration(milliseconds: 200));
      setTransitionIntensity(1.5);
    } else {
      // En modo release, usar configuraciones optimizadas
      setTransitionDuration(const Duration(milliseconds: 300));
      setTransitionIntensity(1.0);
    }
  }
}

/// Tipos de transición disponibles
enum FormTransitionType {
  slide,
  slideScale,
  fadeSlide,
  layered,
}

/// Widget para configurar las transiciones
class TransitionSettings extends StatefulWidget {
  const TransitionSettings({super.key});

  @override
  State<TransitionSettings> createState() => _TransitionSettingsState();
}

class _TransitionSettingsState extends State<TransitionSettings> {
  final _manager = FormTransitionManager();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _manager,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Configuración de Transiciones'),
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionHeader('Tipo de Transición'),
              _buildTransitionTypeSelector(),
              const SizedBox(height: 24),
              
              _buildSectionHeader('Velocidad y Timing'),
              _buildDurationSlider(),
              const SizedBox(height: 16),
              _buildIntensitySlider(),
              const SizedBox(height: 24),
              
              _buildSectionHeader('Feedback'),
              _buildHapticsToggle(),
              const SizedBox(height: 8),
              _buildSoundToggle(),
              const SizedBox(height: 24),
              
              _buildSectionHeader('Curva de Animación'),
              _buildCurveSelector(),
              const SizedBox(height: 24),
              
              _buildSectionHeader('Estadísticas'),
              _buildUsageStats(),
              const SizedBox(height: 24),
              
              _buildActionButtons(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E2E2E),
        ),
      ),
    );
  }

  Widget _buildTransitionTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: FormTransitionType.values.map((type) {
          return RadioListTile<FormTransitionType>(
            title: Text(_getTransitionTypeName(type)),
            subtitle: Text(_getTransitionTypeDescription(type)),
            value: type,
            groupValue: _manager.defaultTransitionType,
            onChanged: (value) {
              if (value != null) {
                _manager.setDefaultTransitionType(value);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDurationSlider() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duración: ${_manager.transitionDuration.inMilliseconds}ms',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Slider(
            value: _manager.transitionDuration.inMilliseconds.toDouble(),
            min: 100,
            max: 800,
            divisions: 14,
            onChanged: (value) {
              _manager.setTransitionDuration(Duration(milliseconds: value.toInt()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIntensitySlider() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Intensidad: ${_manager.transitionIntensity.toStringAsFixed(1)}x',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Slider(
            value: _manager.transitionIntensity,
            min: 0.5,
            max: 2.0,
            divisions: 15,
            onChanged: _manager.setTransitionIntensity,
          ),
        ],
      ),
    );
  }

  Widget _buildHapticsToggle() {
    return SwitchListTile(
      title: const Text('Feedback Háptico'),
      subtitle: const Text('Vibración al navegar entre formularios'),
      value: _manager.hapticsEnabled,
      onChanged: _manager.setHapticsEnabled,
    );
  }

  Widget _buildSoundToggle() {
    return SwitchListTile(
      title: const Text('Sonidos de Transición'),
      subtitle: const Text('Efectos de sonido durante las animaciones'),
      value: _manager.soundEnabled,
      onChanged: _manager.setSoundEnabled,
    );
  }

  Widget _buildCurveSelector() {
    final curves = [
      (Curves.easeInOut, 'Ease In Out'),
      (Curves.easeInOutCubic, 'Ease In Out Cubic'),
      (Curves.fastOutSlowIn, 'Fast Out Slow In'),
      (Curves.bounceInOut, 'Bounce In Out'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: curves.map((curveData) {
          return RadioListTile<Curve>(
            title: Text(curveData.$2),
            value: curveData.$1,
            groupValue: _manager.transitionCurve,
            onChanged: (value) {
              if (value != null) {
                _manager.setTransitionCurve(value);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUsageStats() {
    final stats = _manager.getTransitionUsageStats();
    
    if (stats.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: const Text(
          'No hay estadísticas de uso disponibles',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Uso por tipo de transición:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...stats.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_getTransitionTypeName(entry.key)),
                  Text('${(entry.value * 100).toStringAsFixed(1)}%'),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _manager.autoConfigureForDevice,
            child: const Text('Configuración Automática'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _manager.resetToDefaults,
            child: const Text('Restaurar Valores por Defecto'),
          ),
        ),
      ],
    );
  }

  String _getTransitionTypeName(FormTransitionType type) {
    switch (type) {
      case FormTransitionType.slide:
        return 'Deslizamiento';
      case FormTransitionType.slideScale:
        return 'Deslizamiento + Escala';
      case FormTransitionType.fadeSlide:
        return 'Desvanecimiento + Deslizamiento';
      case FormTransitionType.layered:
        return 'Capas con Profundidad';
    }
  }

  String _getTransitionTypeDescription(FormTransitionType type) {
    switch (type) {
      case FormTransitionType.slide:
        return 'Transición horizontal suave';
      case FormTransitionType.slideScale:
        return 'Combina movimiento y escala';
      case FormTransitionType.fadeSlide:
        return 'Desvanecimiento elegante';
      case FormTransitionType.layered:
        return 'Efecto de profundidad 3D';
    }
  }
}
