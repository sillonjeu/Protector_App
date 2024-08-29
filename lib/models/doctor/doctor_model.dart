class Doctor {
  String licenseNumber;
  String name;
  String hospital;
  String diagnosisCode;

  Doctor({
    required this.licenseNumber,
    required this.name,
    required this.hospital,
    required this.diagnosisCode,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      licenseNumber: json["licenseNumber"],
      name: json["name"],
      hospital: json["hospital"],
      diagnosisCode: json["diagnosisCode"],
    );
  }
}
