class InfrastructureInfo {
  bool hasSalones;
  bool hasComedor;
  bool hasCocina;
  bool hasSalonReuniones;
  bool hasHabitaciones;
  bool hasBanos;
  bool hasOtros;
  String proyectosInfraestructura;
  String propiedadPredio;
  InfrastructureInfo({
    this.hasSalones = false,
    this.hasComedor = false,
    this.hasCocina = false,
    this.hasSalonReuniones = false,
    this.hasHabitaciones = false,
    this.hasBanos = false,
    this.hasOtros = false,
    this.proyectosInfraestructura = '',
    this.propiedadPredio = '',
  });

  Map<String, dynamic> toJson() => {
    'hasSalones': hasSalones,
    'hasComedor': hasComedor,
    'hasCocina': hasCocina,
    'hasSalonReuniones': hasSalonReuniones,
    'hasHabitaciones': hasHabitaciones,
    'hasBanos': hasBanos,
    'hasOtros': hasOtros,
    'proyectosInfraestructura': proyectosInfraestructura,
    'propiedadPredio': propiedadPredio,
  };
  factory InfrastructureInfo.fromJson(Map<String, dynamic> json) {
    return InfrastructureInfo(
      hasSalones: json['hasSalones'] ?? false,
      hasComedor: json['hasComedor'] ?? false,
      hasCocina: json['hasCocina'] ?? false,
      hasSalonReuniones: json['hasSalonReuniones'] ?? false,
      hasHabitaciones: json['hasHabitaciones'] ?? false,
      hasBanos: json['hasBanos'] ?? false,
      hasOtros: json['hasOtros'] ?? false,
      proyectosInfraestructura: json['proyectosInfraestructura'] ?? '',
      propiedadPredio: json['propiedadPredio'] ?? '',
    );
  }
}
