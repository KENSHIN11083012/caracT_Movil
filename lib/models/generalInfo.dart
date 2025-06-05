class GeneralInfo {
  DateTime? date;
  String? department;
  String? municipality;
  String? district;
  String? village;
  String? intervieweeName;
  String? contact;

  GeneralInfo({
    this.date,
    this.department,
    this.municipality,
    this.district,
    this.village,
    this.intervieweeName,
    this.contact,
  });

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