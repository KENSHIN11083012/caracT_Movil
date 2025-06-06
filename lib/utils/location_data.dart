class LocationData {
  static const Map<String, List<String>> departmentMunicipalities = {
    'Amazonas': ['Leticia', 'Puerto Nariño'],
    'Antioquia': [
      'Medellín',
      'Abejorral',
      'Abriaquí',
      'Alejandría',
      'Amagá',
      'Amalfi',
      'Apartadó',
      'Bello',
      'Caucasia',
      'Envigado',
      'Itagüí',
      'Rionegro',
      'Sabaneta',
      'Turbo',
    ],
    'Atlántico': [
      'Barranquilla',
      'Soledad',
      'Malambo',
      'Sabanalarga',
      'Puerto Colombia',
    ],
    'Bolívar': [
      'Cartagena',
      'Magangué',
      'Carmen de Bolívar',
      'Turbaco',
      'Arjona',
    ],
    'Boyacá': [
      'Tunja',
      'Duitama',
      'Sogamoso',
      'Chiquinquirá',
      'Paipa',
    ],
    'Caldas': [
      'Manizales',
      'La Dorada',
      'Chinchiná',
      'Villamaría',
      'Anserma',
    ],
    'Cundinamarca': [
      'Bogotá',
      'Soacha',
      'Facatativá',
      'Zipaquirá',
      'Chía',
      'Mosquera',
    ],
    'Norte de Santander': [
      'Ábrego',
      'Arboledas',
      'Bochalema',
      'Bucarasica',
      'Cácota',
      'Cáchira',
      'Chinácota',
      'Chitagá',
      'Convención',
      'Cúcuta',
      'Cucutilla',
      'Durania',
      'El Carmen',
      'El Tarra',
      'El Zulia',
      'Gramalote',
      'Hacarí',
      'Herrán',
      'La Esperanza',
      'La Playa',
      'Labateca',
      'Los Patios',
      'Lourdes',
      'Mutiscua',
      'Ocaña',
      'Pamplona',
      'Pamplonita',
      'Puerto Santander',
      'Ragonvalia',
      'Salazar',
      'San Calixto',
      'San Cayetano',
      'Santiago',
      'Sardinata',
      'Silos',
      'Teorama',
      'Tibú',
      'Toledo',
      'Villa Caro',
      'Villa del Rosario'
    ],
    'Cesar': [
      'Aguachica',
      'Agustín Codazzi',
      'Astrea',
      'Becerril',
      'Bosconia',
      'Chimichagua',
      'Chiriguaná',
      'Curumaní',
      'El Copey',
      'El Paso',
      'Gamarra',
      'González',
      'La Gloria',
      'La Jagua de Ibirico',
      'La Paz',
      'Manaure',
      'Pailitas',
      'Pelaya',
      'Pueblo Bello',
      'Río de Oro',
      'San Alberto',
      'San Diego',
      'San Martín',
      'Tamalameque',
      'Valledupar'
    ]
  };

  static List<String> get departments => departmentMunicipalities.keys.toList()..sort();

  static List<String> getMunicipalities(String department) {
    final municipalitiesList = departmentMunicipalities[department]?.toList() ?? [];
    municipalitiesList.sort();
    return municipalitiesList;
  }

  static List<String> filterDepartments(String query) {
    query = query.toLowerCase().trim();
    return departments
        .where((dept) => dept.toLowerCase().contains(query))
        .toList();
  }

  static List<String> filterMunicipalities(String department, String query) {
    query = query.toLowerCase().trim();
    final municipalities = getMunicipalities(department);
    return municipalities
        .where((mun) => mun.toLowerCase().contains(query))
        .toList();
  }
}
