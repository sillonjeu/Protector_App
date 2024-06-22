import 'package:intl/intl.dart';

class Telemedicine {
  int medicalHistoryId;
  int doctorId;
  String prescription;
  String diagnoise;
  DateTime visitAt;

  Telemedicine({
    required this.medicalHistoryId,
    required this.doctorId,
    required this.prescription,
    required this.diagnoise,
    required this.visitAt,
  });

  factory Telemedicine.fromJson(Map<String, dynamic> json) {
    return Telemedicine(
      medicalHistoryId: json['medicalHistoryId'],
      doctorId: json['doctorId'],
      prescription: json['prescription'],
      diagnoise: json['diagnoise'],
      visitAt: DateTime.parse(json['visitAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicalHistoryId': medicalHistoryId,
      'doctorId': doctorId,
      'prescription': prescription,
      'diagnoise': diagnoise,
      'visitAt': visitAt.toIso8601String(),
    };
  }

  // DateTime을 "년.월.일" 형식의 문자열로 변환하는 메소드
  String getFormattedVisitDate() {
    return DateFormat('yyyy.MM.dd').format(visitAt);
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