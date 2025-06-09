class ElectricityInfo {
  bool hasElectricService;
  bool interestedInSolarPanels;

  ElectricityInfo({
    this.hasElectricService = false,
    this.interestedInSolarPanels = false,
  });

  Map<String, dynamic> toJson() => {
    'hasElectricService': hasElectricService,
    'interestedInSolarPanels': interestedInSolarPanels,
  };

  factory ElectricityInfo.fromJson(Map<String, dynamic> json) {
    return ElectricityInfo(
      hasElectricService: json['hasElectricService'] ?? false,
      interestedInSolarPanels: json['interestedInSolarPanels'] ?? false,
    );
  }
}
