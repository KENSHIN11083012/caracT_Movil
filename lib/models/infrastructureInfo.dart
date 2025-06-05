class InfrastructureInfo {
  String? buildingType;
  int? classroomsCount;
  int? bathroomsCount;
  String? waterSource;
  String? electricitySource;
  String? internetAccess;
  String? sportsFacilities;
  String? laboratory;
  String? computerRoom;
  String? library;

  InfrastructureInfo({
    this.buildingType,
    this.classroomsCount,
    this.bathroomsCount,
    this.waterSource,
    this.electricitySource,
    this.internetAccess,
    this.sportsFacilities,
    this.laboratory,
    this.computerRoom,
    this.library,
  });

  Map<String, dynamic> toJson() => {
    'buildingType': buildingType,
    'classroomsCount': classroomsCount,
    'bathroomsCount': bathroomsCount,
    'waterSource': waterSource,
    'electricitySource': electricitySource,
    'internetAccess': internetAccess,
    'sportsFacilities': sportsFacilities,
    'laboratory': laboratory,
    'computerRoom': computerRoom,
    'library': library,
  };
}
