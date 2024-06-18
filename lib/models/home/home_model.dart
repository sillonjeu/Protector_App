class PatientDrugMetricSummaryDto {
  List<DrugDose>? drugDoseList;
  PatientName? patientName;
  List<MetricSummary>? metricSummary;

  PatientDrugMetricSummaryDto({
    this.drugDoseList,
    this.patientName,
    this.metricSummary,
  });

  factory PatientDrugMetricSummaryDto.fromJson(Map<String, dynamic> json) => PatientDrugMetricSummaryDto(
    drugDoseList: List<DrugDose>.from(json["DrugDoseList"].map((x) => DrugDose.fromJson(x))),
    patientName: json["PatientName"] == null ? null : PatientName.fromJson(json["PatientName"]),
    metricSummary: List<MetricSummary>.from(json["MetricSummary"].map((x) => MetricSummary.fromJson(x))),
  );
}

class DrugDose {
  String drugCode;
  String drugName;
  double singleDose;
  int dosesPerDay;
  int durationDay;
  String description;
  bool alarm;
  String alarmType; // 이 부분은 enum으로 변경하면 됩니다.
  // DateTime or String alarmTime; // 알람 시간 형식은 구현 시 결정

  DrugDose({
    required this.drugCode,
    required this.drugName,
    required this.singleDose,
    required this.dosesPerDay,
    required this.durationDay,
    required this.description,
    required this.alarm,
    required this.alarmType,
    // this.alarmTime,
  });

  factory DrugDose.fromJson(Map<String, dynamic> json) => DrugDose(
    drugCode: json["drugCode"],
    drugName: json["drugName"],
    singleDose: json["singleDose"].toDouble(),
    dosesPerDay: json["dosesPerDay"],
    durationDay: json["durationDay"],
    description: json["description"],
    alarm: json["alarm"],
    alarmType: json["alarmType"],
    // alarmTime: json["alarmTime"], // 시간 형식에 따라 파싱
  );
}

class PatientName {
  String name;

  PatientName({
    required this.name,
  });

  factory PatientName.fromJson(Map<String, dynamic> json) => PatientName(
    name: json["name"],
  );
}

class MetricSummary {
  String name;
  dynamic value; // 타입이 결정되면 해당 타입으로 변경

  MetricSummary({
    required this.name,
    required this.value,
  });

  factory MetricSummary.fromJson(Map<String, dynamic> json) => MetricSummary(
    name: json["name"],
    value: json["value"],
  );
}

class WearOs {
  final String id;
  final String name;

  WearOs({required this.id, required this.name});

  // Map 객체에서 새로운 인스턴스를 생성하는 팩토리 메서드
  factory WearOs.fromMap(Map<String, dynamic> map) {
    return WearOs(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  // 객체를 설명하는 문자열을 반환
  @override
  String toString() => 'Device ID: $id, Name: $name';
}
