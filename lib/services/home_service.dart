import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/home_model.dart';
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
