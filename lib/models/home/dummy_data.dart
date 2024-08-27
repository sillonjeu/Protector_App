import 'dart:convert';

class DummyData {
  static String heartRateData = json.encode([
    {"average": 100.655, "minimum": 83, "maximum": 113},
    {"average": 113.428, "minimum": 82, "maximum": 146},
    {"average": 130.546, "minimum": 117, "maximum": 143},
    {"average": 94.6886, "minimum": 70, "maximum": 141},
    {"average": 123.5, "minimum": 121, "maximum": 127},
    {"average": 130.194, "minimum": 121, "maximum": 136}
  ]);

  static String oxygenSaturationData = json.encode([
    {"value": 0.97},
    {"value": 0.96},
    {"value": 0.99},
    {"value": 0.94},
    {"value": 0.98},
    {"value": 0.95},
    {"value": 0.96},
    {"value": 0.96},
    {"value": 1.00},
    {"value": 0.96}
  ]);

  static String respiratoryRateData = json.encode([
    {"value": 12.5},
    {"value": 12.5},
    {"value": 13.5},
    {"value": 13.0},
    {"value": 11.5},
    {"value": 12.0},
    {"value": 12.5},
    {"value": 12.5},
    {"value": 12.0},
    {"value": 12.0}
  ]);

  static String restingHeartRateData = json.encode([
    {"value": 59},
    {"value": 59},
    {"value": 64},
    {"value": 72},
    {"value": 66},
    {"value": 60},
    {"value": 57},
    {"value": 61},
    {"value": 61},
    {"value": 64}
  ]);

  static String sdnnData = json.encode([
    {"value": 46.4562},
    {"value": 46.2239},
    {"value": 132.142},
    {"value": 52.3698},
    {"value": 48.7531},
    {"value": 55.9012},
    {"value": 61.2345},
    {"value": 58.7890},
    {"value": 49.6543},
    {"value": 53.2109}
  ]);


  static String bloodPressureData = json.encode([
    {"systolic": 120, "diastolic": 80, "date": "2023-08-01"},
    {"systolic": 118, "diastolic": 78, "date": "2023-08-02"},
    {"systolic": 122, "diastolic": 82, "date": "2023-08-03"},
    {"systolic": 121, "diastolic": 79, "date": "2023-08-04"},
    {"systolic": 119, "diastolic": 81, "date": "2023-08-05"},
    {"systolic": 123, "diastolic": 83, "date": "2023-08-06"},
    {"systolic": 117, "diastolic": 77, "date": "2023-08-07"}
  ]);


  static String ecgData = json.encode([
    {"time": 0, "voltage": 0.0},
    {"time": 100, "voltage": 0.1},
    {"time": 200, "voltage": 0.3},
    {"time": 300, "voltage": 1.0},
    {"time": 400, "voltage": 0.7},
    {"time": 500, "voltage": 0.5},
    {"time": 600, "voltage": 0.2},
    {"time": 700, "voltage": 0.0},
    {"time": 800, "voltage": -0.1},
    {"time": 900, "voltage": -0.2},
    {"time": 1000, "voltage": 0.0}
  ]);

}