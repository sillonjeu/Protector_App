class Doctor {
  String licenseNumber;

  Doctor({required this.licenseNumber});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        licenseNumber: json["licenseNumber"] // JSON 키가 licenseNumber라고 가정
    );
  }
}