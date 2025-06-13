import 'package:flutter/foundation.dart';
import 'generalInfo.dart';
import 'institutionalInfo.dart';
import 'coverageInfo.dart';
import 'infrastructureInfo.dart';
import 'observationsInfo.dart';
import 'electricity_info.dart';
import 'appliances_info.dart';
import 'access_route_info.dart';
import 'photographic_record_info.dart';

class SurveyState extends ChangeNotifier {
  GeneralInfo generalInfo = GeneralInfo();
  InstitutionalInfo institutionalInfo = InstitutionalInfo();
  CoverageInfo coverageInfo = CoverageInfo();
  InfrastructureInfo infrastructureInfo = InfrastructureInfo();
  ObservationsInfo observationsInfo = ObservationsInfo();
  ElectricityInfo electricityInfo = ElectricityInfo();
  AppliancesInfo appliancesInfo = AppliancesInfo();
  AccessRouteInfo accessRouteInfo = AccessRouteInfo();
  PhotographicRecordInfo photographicRecordInfo = PhotographicRecordInfo();

  void updateGeneralInfo(GeneralInfo info) {
    generalInfo = info;
    notifyListeners();
  }

  void updateInstitutionalInfo(InstitutionalInfo info) {
    institutionalInfo = info;
    notifyListeners();
  }

  void updateCoverageInfo(CoverageInfo info) {
    coverageInfo = info;
    notifyListeners();
  }

  void updateInfrastructureInfo(InfrastructureInfo info) {
    infrastructureInfo = info;
    notifyListeners();
  }

  void updateElectricityInfo(ElectricityInfo info) {
    electricityInfo = info;
    notifyListeners();
  }

  void updateAppliancesInfo(AppliancesInfo info) {
    appliancesInfo = info;
    notifyListeners();
  }
  void updateAccessRouteInfo(AccessRouteInfo info) {
    accessRouteInfo = info;
    notifyListeners();
  }

  void updatePhotographicRecordInfo(PhotographicRecordInfo info) {
    photographicRecordInfo = info;
    notifyListeners();
  }

  void updateObservationsInfo(ObservationsInfo info) {
    observationsInfo = info;
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
    'generalInfo': generalInfo.toJson(),
    'institutionalInfo': institutionalInfo.toJson(),
    'coverageInfo': coverageInfo.toJson(),
    'infrastructureInfo': infrastructureInfo.toJson(),
    'observationsInfo': observationsInfo.toJson(),
    'electricityInfo': electricityInfo.toJson(),
    'appliancesInfo': appliancesInfo.toJson(),
    'accessRouteInfo': accessRouteInfo.toJson(),
    'photographicRecordInfo': photographicRecordInfo.toJson(),
  };
}
