import 'package:hive_flutter/hive_flutter.dart';
import '../models/generalInfo.dart';
import '../models/institutionalInfo.dart';
import '../models/infrastructureInfo.dart';

class StorageService {
  static const String _surveyBox = 'survey_box';
  static const String _infrastructureBox = 'infrastructure_box';

  static Future<void> init() async {
    await Hive.initFlutter();
  }

  static Future<void> saveSurveyData({
    GeneralInfo? generalInfo,
    InstitutionalInfo? institutionalInfo,
    InfrastructureInfo? infrastructureInfo,
  }) async {
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
    final box = await Hive.openBox(_surveyBox);
    final List<Map<String, dynamic>> pendingSurveys = [];

    for (var key in box.keys) {
      final survey = box.get(key);
      if (survey['syncStatus'] == 'pending') {
        pendingSurveys.add(Map<String, dynamic>.from(survey));
      }
    }

    return pendingSurveys;
  }
  static Future<void> markSurveyAsSynced(String surveyId) async {
    final box = await Hive.openBox(_surveyBox);
    final survey = box.get(surveyId);
    if (survey != null) {
      survey['syncStatus'] = 'synced';
      await box.put(surveyId, survey);
    }
  }

  static Future<void> saveInfrastructureInfo(InfrastructureInfo info) async {
    final box = await Hive.openBox(_infrastructureBox);
    await box.put('current', info.toJson());
  }
  static Future<InfrastructureInfo?> getInfrastructureInfo() async {
    final box = await Hive.openBox(_infrastructureBox);
    final data = box.get('current');
    if (data != null) {
      return InfrastructureInfo.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static Future<void> clearInfrastructureData() async {
    final box = await Hive.openBox(_infrastructureBox);
    await box.delete('current');
  }
}
