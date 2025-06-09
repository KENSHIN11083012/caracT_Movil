class PhotographicRecordInfo {
  String? frontSchoolPhoto;
  String? classroomsPhoto;
  String? kitchenPhoto;
  String? diningRoomPhoto;

  PhotographicRecordInfo({
    this.frontSchoolPhoto,
    this.classroomsPhoto,
    this.kitchenPhoto,
    this.diningRoomPhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'frontSchoolPhoto': frontSchoolPhoto,
      'classroomsPhoto': classroomsPhoto,
      'kitchenPhoto': kitchenPhoto,
      'diningRoomPhoto': diningRoomPhoto,
    };
  }

  factory PhotographicRecordInfo.fromJson(Map<String, dynamic> json) {
    return PhotographicRecordInfo(
      frontSchoolPhoto: json['frontSchoolPhoto'],
      classroomsPhoto: json['classroomsPhoto'],
      kitchenPhoto: json['kitchenPhoto'],
      diningRoomPhoto: json['diningRoomPhoto'],
    );
  }

  PhotographicRecordInfo copyWith({
    String? frontSchoolPhoto,
    String? classroomsPhoto,
    String? kitchenPhoto,
    String? diningRoomPhoto,
  }) {
    return PhotographicRecordInfo(
      frontSchoolPhoto: frontSchoolPhoto ?? this.frontSchoolPhoto,
      classroomsPhoto: classroomsPhoto ?? this.classroomsPhoto,
      kitchenPhoto: kitchenPhoto ?? this.kitchenPhoto,
      diningRoomPhoto: diningRoomPhoto ?? this.diningRoomPhoto,
    );
  }
}
