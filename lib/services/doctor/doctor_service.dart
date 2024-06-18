import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/doctor/doctor_model.dart';

class DoctorService {
  Future<List<Doctor>> fetchDoctors() async {
    // 환경변수에서 API 엔드포인트를 불러옵니다.
    String apiUrl = '${dotenv.env['API']}/doctors'; // 엔드포인트 주소 확인 필요

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받았을 때
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Doctor.fromJson(item)).toList();
    } else {
      // 에러 처리
      throw Exception('Failed to load doctor data');
    }
  }
}