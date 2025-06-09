class ElectricityInfo {
  bool? hasElectricService;
  bool? interestedInSolarPanels;
  ElectricityInfo({
    this.hasElectricService,
    this.interestedInSolarPanels,
  });
  Map<String, dynamic> toJson() => {
    'hasElectricService': hasElectricService,
    'interestedInSolarPanels': interestedInSolarPanels,
  };
  factory ElectricityInfo.fromJson(Map<String, dynamic> json) {
    return ElectricityInfo(
      hasElectricService: json['hasElectricService'],
      interestedInSolarPanels: json['interestedInSolarPanels'],
    );
  }

  ElectricityInfo copyWith({
    bool? hasElectricService,
    bool? interestedInSolarPanels,
  }) {
    return ElectricityInfo(
      hasElectricService: hasElectricService ?? this.hasElectricService,
      interestedInSolarPanels: interestedInSolarPanels ?? this.interestedInSolarPanels,
    );
  }
}
