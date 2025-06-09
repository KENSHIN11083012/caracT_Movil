class ObservationsInfo {
  String? additionalObservations;
  Map<String, String>? photos;

  ObservationsInfo({
    this.additionalObservations,
    this.photos,
  });

  Map<String, dynamic> toJson() => {
    'additionalObservations': additionalObservations,
    'photos': photos,
  };
}
