import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hanieum/models/telemedicine/telemedicine_model.dart';
import 'package:http/http.dart' as http;

class TelemedicineService {
  Future<List<Telemedicine>> fetchTelemedicines() async {
    String apiUrl = '${dotenv.env['API']}/medical/history'; // Todo: 엔드포인트 주소 확인 필요
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Telemedicine.fromJson(item)).toList();
    } else {
      // 에러 처리
      throw Exception('Failed to load Telemedicine data');
    }
  }

  Future<List<TelemedicineDetail>> fetchTelemedicineDetails() async {
    int medicalHistoryId = 1; // Todo: 예시 ID, 실제로는 필요에 따라 조정
    String apiUrl = '${dotenv.env['API']}/solution/detail/$medicalHistoryId';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => TelemedicineDetail.fromJson(item)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('No solution found for the given ID.');
      } else if (response.statusCode == 403) {
        throw Exception('Access to the resource is forbidden.');
      } else {
        throw Exception('Failed to load Telemedicine data with status code: ${response.statusCode}');
      }
    } catch (e) {
      // 네트워크 에러 혹은 데이터 파싱 에러 처리
      print(e.toString());
      throw Exception('Error occurred while fetching Telemedicine details: $e');
    }
  }
}