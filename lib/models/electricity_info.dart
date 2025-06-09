class ElectricityInfo {
  bool? hasElectricService;
  bool? interestedInSolarPanels;

  ElectricityInfo({
    this.hasElectricService = false,
    this.interestedInSolarPanels = false,
  });

  Map<String, dynamic> toJson() => {
    'hasElectricService': hasElectricService ?? false,
    'interestedInSolarPanels': interestedInSolarPanels ?? false,
  };

  factory ElectricityInfo.fromJson(Map<String, dynamic> json) {
    return ElectricityInfo(
      hasElectricService: json['hasElectricService'] ?? false,
      interestedInSolarPanels: json['interestedInSolarPanels'] ?? false,
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
