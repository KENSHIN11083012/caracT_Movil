class ObservationsInfo {
  String? generalObservations;
  String? recommendations;
  String? additionalNotes;
  String? additionalObservations; // Agregando propiedad faltante

  ObservationsInfo({
    this.generalObservations,
    this.recommendations,
    this.additionalNotes,
    this.additionalObservations, // Agregando al constructor
  });

  Map<String, dynamic> toJson() => {
    'generalObservations': generalObservations,
    'recommendations': recommendations,
    'additionalNotes': additionalNotes,
    'additionalObservations': additionalObservations, // Agregando al toJson
  };

  factory ObservationsInfo.fromJson(Map<String, dynamic> json) {
    return ObservationsInfo(
      generalObservations: json['generalObservations'],
      recommendations: json['recommendations'],
      additionalNotes: json['additionalNotes'],
      additionalObservations: json['additionalObservations'], // Agregando fromJson
    );
  }

  ObservationsInfo copyWith({
    String? generalObservations,
    String? recommendations,
    String? additionalNotes,
    String? additionalObservations, // Agregando a copyWith
  }) {
    return ObservationsInfo(
      generalObservations: generalObservations ?? this.generalObservations,
      recommendations: recommendations ?? this.recommendations,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      additionalObservations: additionalObservations ?? this.additionalObservations, // Agregando a copyWith
    );
  }
}
