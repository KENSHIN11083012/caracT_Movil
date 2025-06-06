class CoverageInfo {
  int? totalStudents;
  int? boysCount;
  int? girlsCount;
  int? teachersCount;
  List<String>? educationalLevels;

  CoverageInfo({
    this.totalStudents,
    this.boysCount,
    this.girlsCount,
    this.teachersCount,
    this.educationalLevels,
  });

  Map<String, dynamic> toJson() => {
    'totalStudents': totalStudents,
    'boysCount': boysCount,
    'girlsCount': girlsCount,
    'teachersCount': teachersCount,
    'educationalLevels': educationalLevels,
  };
}
