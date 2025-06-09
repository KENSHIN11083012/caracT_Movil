class InstitutionalInfo {
  String? institutionName;
  String? dane;
  String? institutionType;
  String? zone;
  String? sector;
  String? calendar;
  String? category;
  String? principalName;
  String? location;
  String? locationCoordinates;
  String? educationalHeadquarters; // Agregando propiedad faltante
  String? contact; // Agregando propiedad faltante
  String? email; // Agregando propiedad faltante

  InstitutionalInfo({
    this.institutionName,
    this.dane,
    this.institutionType,
    this.zone,
    this.sector,
    this.calendar,
    this.category,
    this.principalName,
    this.location,
    this.locationCoordinates,
    this.educationalHeadquarters, // Agregando al constructor
    this.contact, // Agregando al constructor
    this.email, // Agregando al constructor
  });

  Map<String, dynamic> toJson() => {
    'institutionName': institutionName,
    'dane': dane,
    'institutionType': institutionType,
    'zone': zone,
    'sector': sector,
    'calendar': calendar,
    'category': category,
    'principalName': principalName,
    'location': location,
    'locationCoordinates': locationCoordinates,
    'educationalHeadquarters': educationalHeadquarters, // Agregando al toJson
    'contact': contact, // Agregando al toJson
    'email': email, // Agregando al toJson
  };

  factory InstitutionalInfo.fromJson(Map<String, dynamic> json) {
    return InstitutionalInfo(
      institutionName: json['institutionName'],
      dane: json['dane'],
      institutionType: json['institutionType'],
      zone: json['zone'],
      sector: json['sector'],
      calendar: json['calendar'],
      category: json['category'],
      principalName: json['principalName'],
      location: json['location'],
      locationCoordinates: json['locationCoordinates'],
      educationalHeadquarters: json['educationalHeadquarters'], // Agregando propiedad faltante
      contact: json['contact'], // Agregando propiedad faltante
      email: json['email'], // Agregando propiedad faltante
    );
  }

  InstitutionalInfo copyWith({
    String? institutionName,
    String? dane,
    String? institutionType,
    String? zone,
    String? sector,
    String? calendar,
    String? category,
    String? principalName,
    String? location,
    String? locationCoordinates,
    String? educationalHeadquarters, // Agregando propiedad faltante
    String? contact, // Agregando propiedad faltante
    String? email, // Agregando propiedad faltante
  }) {
    return InstitutionalInfo(
      institutionName: institutionName ?? this.institutionName,
      dane: dane ?? this.dane,
      institutionType: institutionType ?? this.institutionType,
      zone: zone ?? this.zone,
      sector: sector ?? this.sector,
      calendar: calendar ?? this.calendar,
      category: category ?? this.category,
      principalName: principalName ?? this.principalName,
      location: location ?? this.location,
      locationCoordinates: locationCoordinates ?? this.locationCoordinates,
      educationalHeadquarters: educationalHeadquarters ?? this.educationalHeadquarters, // Agregando propiedad faltante
      contact: contact ?? this.contact, // Agregando propiedad faltante
      email: email ?? this.email, // Agregando propiedad faltante
    );
  }
}
