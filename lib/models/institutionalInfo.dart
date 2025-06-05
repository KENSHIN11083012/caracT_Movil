class InstitutionalInfo {
  String? institutionName;
  String? educationalHeadquarters;
  String? location;
  String? principalName;
  String? contact;
  String? email;

  InstitutionalInfo({
    this.institutionName,
    this.educationalHeadquarters,
    this.location,
    this.principalName,
    this.contact,
    this.email,
  });

  Map<String, dynamic> toJson() => {
    'institutionName': institutionName,
    'educationalHeadquarters': educationalHeadquarters,
    'location': location,
    'principalName': principalName,
    'contact': contact,
    'email': email,
  };
}
