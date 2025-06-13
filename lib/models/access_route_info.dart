class AccessRouteInfo {
  String? principalRoute;
  String? routeCondition;
  String? routeDescription; // Agregando la propiedad faltante
  String? transportationType;
  String? accessDifficulties;
  bool? hasPublicTransport;
  String? transportSchedule;
  double? distanceToMainRoad;
  String? routeObservations;

  AccessRouteInfo({
    this.principalRoute,
    this.routeCondition,
    this.routeDescription, // Agregando al constructor
    this.transportationType,
    this.accessDifficulties,
    this.hasPublicTransport,
    this.transportSchedule,
    this.distanceToMainRoad,
    this.routeObservations,
  });

  Map<String, dynamic> toJson() => {
    'principalRoute': principalRoute,
    'routeCondition': routeCondition,
    'routeDescription': routeDescription, // Agregando al toJson
    'transportationType': transportationType,
    'accessDifficulties': accessDifficulties,
    'hasPublicTransport': hasPublicTransport,
    'transportSchedule': transportSchedule,
    'distanceToMainRoad': distanceToMainRoad,
    'routeObservations': routeObservations,
  };

  factory AccessRouteInfo.fromJson(Map<String, dynamic> json) {
    return AccessRouteInfo(
      principalRoute: json['principalRoute'],
      routeCondition: json['routeCondition'],
      routeDescription: json['routeDescription'], // Agregando desdeJson
      transportationType: json['transportationType'],
      accessDifficulties: json['accessDifficulties'],
      hasPublicTransport: json['hasPublicTransport'],
      transportSchedule: json['transportSchedule'],
      distanceToMainRoad: json['distanceToMainRoad']?.toDouble(),
      routeObservations: json['routeObservations'],
    );
  }

  AccessRouteInfo copyWith({
    String? principalRoute,
    String? routeCondition,
    String? routeDescription, // Agregando al copyWith
    String? transportationType,
    String? accessDifficulties,
    bool? hasPublicTransport,
    String? transportSchedule,
    double? distanceToMainRoad,
    String? routeObservations,
  }) {
    return AccessRouteInfo(
      principalRoute: principalRoute ?? this.principalRoute,
      routeCondition: routeCondition ?? this.routeCondition,
      routeDescription: routeDescription ?? this.routeDescription, // Agregando al copyWith
      transportationType: transportationType ?? this.transportationType,
      accessDifficulties: accessDifficulties ?? this.accessDifficulties,
      hasPublicTransport: hasPublicTransport ?? this.hasPublicTransport,
      transportSchedule: transportSchedule ?? this.transportSchedule,
      distanceToMainRoad: distanceToMainRoad ?? this.distanceToMainRoad,
      routeObservations: routeObservations ?? this.routeObservations,
    );
  }
}
