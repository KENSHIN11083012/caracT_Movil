class GeneralInfo {
  DateTime? date;
  String? department;
  String? municipality;
  String? district;
  String? village;
  String? intervieweeName;
  String? contact;

  GeneralInfo({
    DateTime? date,
    this.department,
    this.municipality,
    this.district,
    this.village,
    this.intervieweeName,
    this.contact,
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'date': date?.toIso8601String(),
    'department': department,
    'municipality': municipality,
    'district': district,
    'village': village,
    'intervieweeName': intervieweeName,
    'contact': contact,
  };
}