class PhotographicRecordInfo {
  String? generalPhoto;
  String? infrastructurePhoto;
  String? electricityPhoto;
  String? environmentPhoto;
  String? additionalPhotos;
  String? frontSchoolPhoto;
  String? classroomsPhoto;
  String? kitchenPhoto;
  String? diningRoomPhoto;

  PhotographicRecordInfo({
    this.generalPhoto,
    this.infrastructurePhoto,
    this.electricityPhoto,
    this.environmentPhoto,
    this.additionalPhotos,
    this.frontSchoolPhoto,
    this.classroomsPhoto,
    this.kitchenPhoto,
    this.diningRoomPhoto,
  });
  Map<String, dynamic> toJson() => {
    'generalPhoto': generalPhoto,
    'infrastructurePhoto': infrastructurePhoto,
    'electricityPhoto': electricityPhoto,
    'environmentPhoto': environmentPhoto,
    'additionalPhotos': additionalPhotos,
    'frontSchoolPhoto': frontSchoolPhoto,
    'classroomsPhoto': classroomsPhoto,
    'kitchenPhoto': kitchenPhoto,
    'diningRoomPhoto': diningRoomPhoto,
  };
  factory PhotographicRecordInfo.fromJson(Map<String, dynamic> json) {
    return PhotographicRecordInfo(
      generalPhoto: json['generalPhoto'] as String?,
      infrastructurePhoto: json['infrastructurePhoto'] as String?,
      electricityPhoto: json['electricityPhoto'] as String?,
      environmentPhoto: json['environmentPhoto'] as String?,
      additionalPhotos: json['additionalPhotos'] as String?,
      frontSchoolPhoto: json['frontSchoolPhoto'] as String?,
      classroomsPhoto: json['classroomsPhoto'] as String?,
      kitchenPhoto: json['kitchenPhoto'] as String?,
      diningRoomPhoto: json['diningRoomPhoto'] as String?,
    );
  }

  PhotographicRecordInfo copyWith({
    String? generalPhoto,
    String? infrastructurePhoto,
    String? electricityPhoto,
    String? environmentPhoto,
    String? additionalPhotos,
  }) {
    return PhotographicRecordInfo(
      generalPhoto: generalPhoto ?? this.generalPhoto,
      infrastructurePhoto: infrastructurePhoto ?? this.infrastructurePhoto,
      electricityPhoto: electricityPhoto ?? this.electricityPhoto,
      environmentPhoto: environmentPhoto ?? this.environmentPhoto,
      additionalPhotos: additionalPhotos ?? this.additionalPhotos,
    );
  }
}