class Telemedicine {
  int medicalHistoryId;
  int doctorId;
  String prescription;
  String diagnoise;
  DateTime visitAt;

  // prescription이랑 diagnoise는 각각 pdf 형식 -> url로 넘겨줌
  Telemedicine({
    required this.medicalHistoryId,
    required this.doctorId,
    required this.prescription,
    required this.diagnoise,
    required this.visitAt,
  });

  // JSON에서 MedicalHistory 객체를 생성하는 팩토리 생성자
  factory Telemedicine.fromJson(Map<String, dynamic> json) {
    return Telemedicine(
      medicalHistoryId: json['medicalHistoryId'],
      doctorId: json['doctorId'],
      prescription: json['prescription'],
      diagnoise: json['diagnoise'],
      visitAt: DateTime.parse(json['visitAt']),
    );
  }

  // MedicalHistory 객체를 JSON 맵으로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'medicalHistoryId': medicalHistoryId,
      'doctorId': doctorId,
      'prescription': prescription,
      'diagnoise': diagnoise,
      'visitAt': visitAt.toIso8601String(),
    };
  }
}

class TelemedicineDetail {
  String description;

  TelemedicineDetail({
    required this.description,
  });

  factory TelemedicineDetail.fromJson(Map<String, dynamic> json) {
    return TelemedicineDetail(
      description: json['medicalHistoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
    };
  }
}