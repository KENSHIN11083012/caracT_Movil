import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/generalInfo.dart';
import '../models/institutionalInfo.dart';
import '../models/infrastructureInfo.dart';
import '../models/photographic_record_info.dart';

class StorageService {
  static const String _surveyBox = 'survey_box';
  static const String _infrastructureBox = 'infrastructure_box';
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      // Obtener el directorio de documentos de la aplicación
      final appDocumentDir = await getApplicationDocumentsDirectory();
      
      // Inicializar Hive con la ruta específica
      await Hive.initFlutter(appDocumentDir.path);
      
      _isInitialized = true;
      print('Hive inicializado correctamente en: ${appDocumentDir.path}');
    } catch (e) {
      print('Error al inicializar Hive: $e');
      rethrow;
    }
  }

  static Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }
  static Future<void> saveSurveyData({
    GeneralInfo? generalInfo,
    InstitutionalInfo? institutionalInfo,
    InfrastructureInfo? infrastructureInfo,
  }) async {
    await _ensureInitialized();
    final box = await Hive.openBox(_surveyBox);
    final String surveyId = DateTime.now().toIso8601String();

    final surveyData = {
      'id': surveyId,
      'timestamp': DateTime.now().toIso8601String(),
      'generalInfo': generalInfo?.toJson(),
      'institutionalInfo': institutionalInfo?.toJson(),
      'infrastructureInfo': infrastructureInfo?.toJson(),
      'syncStatus': 'pending',
    };

    await box.put(surveyId, surveyData);
  }
  static Future<List<Map<String, dynamic>>> getPendingSurveys() async {
    await _ensureInitialized();
    final box = await Hive.openBox(_surveyBox);
    final List<Map<String, dynamic>> pendingSurveys = [];

    for (var key in box.keys) {
      final survey = box.get(key);
      if (survey['syncStatus'] == 'pending') {
        pendingSurveys.add(Map<String, dynamic>.from(survey));
      }
    }

    return pendingSurveys;
  }  static Future<void> markSurveyAsSynced(String surveyId) async {
    await _ensureInitialized();
    final box = await Hive.openBox(_surveyBox);
    final survey = box.get(surveyId);
    if (survey != null) {
      survey['syncStatus'] = 'synced';
      await box.put(surveyId, survey);
    }
  }
  static Future<void> saveInfrastructureInfo(InfrastructureInfo info) async {
    await _ensureInitialized();
    final box = await Hive.openBox(_infrastructureBox);
    await box.put('current', info.toJson());
  }  static Future<InfrastructureInfo?> getInfrastructureInfo() async {
    await _ensureInitialized();
    final box = await Hive.openBox(_infrastructureBox);
    final data = box.get('current');
    if (data != null) {
      return InfrastructureInfo.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }
  static Future<void> clearInfrastructureData() async {
    await _ensureInitialized();
    final box = await Hive.openBox(_infrastructureBox);
    await box.delete('current');
  }
  static Future<void> savePhotographicRecordInfo(PhotographicRecordInfo info) async {
    await _ensureInitialized();
    final box = await Hive.openBox(_surveyBox);
    await box.put('photographic_record', info.toJson());
  }

  static Future<PhotographicRecordInfo?> getPhotographicRecordInfo() async {
    await _ensureInitialized();
    final box = await Hive.openBox(_surveyBox);
    final data = box.get('photographic_record');
    if (data != null) {
      return PhotographicRecordInfo.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static Future<void> clearPhotographicRecordData() async {
    await _ensureInitialized();
    final box = await Hive.openBox(_surveyBox);
    await box.delete('photographic_record');
  }
}
