import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import '../../models/home/home_model.dart';
import 'package:http/http.dart' as http;

class PatientDrugService {
  Future<PatientDrugMetricSummaryDto> fetchPatientDrugMetricSummary() async {
    String? mainpageAPI = '${dotenv.env['API']}/나중에 바꾸기/';

    final response = await http.get(Uri.parse(mainpageAPI));
    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받았을 때
      return PatientDrugMetricSummaryDto.fromJson(json.decode(response.body));
    } else {
      // 에러 처리
      throw Exception('Failed to load patient drug metric summary');
    }
  }
}

class WearOsService {
  final FlutterWearOsConnectivity _connectivity = FlutterWearOsConnectivity();

  Future<void> initialize() async {
    await _connectivity.configureWearableAPI();
  }

  Future<List<WearOs>> getConnectedDevices() async {
    var devices = await _connectivity.getConnectedDevices();
    return devices.map((device) => WearOs.fromMap(device as Map<String, dynamic>)).toList();  // 변환 함수가 정의되어 있다고 가정
  }

  Future<String> sendMessage(String message, String deviceId) async {
    await _connectivity.sendMessage(Uint8List.fromList(message.codeUnits), deviceId: deviceId, path: '/sample-message');
    return 'Message sent to $deviceId';
  }
}
