class AccessRouteInfo {
  String? routeDescription;

  AccessRouteInfo({
    this.routeDescription,
  });

  Map<String, dynamic> toJson() => {
    'routeDescription': routeDescription,
  };

  factory AccessRouteInfo.fromJson(Map<String, dynamic> json) {
    return AccessRouteInfo(
      routeDescription: json['routeDescription'] as String?,
    );
  }
}
