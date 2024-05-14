import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:get/get.dart';
import '../../viewModels/home/wear_os_connectivity_viewmodel.dart';
import '../base/base_screen.dart';

class WearOsConnectivityScreen extends BaseScreen<WearOsConnectivityViewModel> {
  WearOsConnectivityScreen({super.key});

  @override
  final WearOsConnectivityViewModel viewModel = Get.find<WearOsConnectivityViewModel>();

  @override
  Widget buildBody(BuildContext context) {
    return HealthDataPage();
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class HealthDataPage extends BaseScreen<WearOsConnectivityViewModel> {
  const HealthDataPage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            children: <Widget>[
              HealthDataContainer(),
              // 다른 컨테이너 추가 가능
            ],
          ),
        ),
      ],
    );
  }
}

class HealthDataContainer extends StatelessWidget {
  HealthDataContainer({super.key});

  final List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.ExerciseSession,
  ];

  Future<void> _fetchHealthData(BuildContext context) async {
    bool readOnly = true;
    String resultText = '';
    String token = '';

    try {
      print('Checking if API is supported...');
      bool isApiSupported = await HealthConnectFactory.isApiSupported();
      print('API Supported: $isApiSupported');

      print('Checking if Health Connect is available...');
      bool isAvailable = await HealthConnectFactory.isAvailable();
      print('Health Connect Available: $isAvailable');

      if (!isAvailable) {
        print('Installing Health Connect...');
        await HealthConnectFactory.installHealthConnect();
        print('Health Connect installation initiated.');
      }

      print('Checking permissions...');
      bool hasPermissions = await HealthConnectFactory.hasPermissions(types, readOnly: readOnly);
      print('Has Permissions: $hasPermissions');

      if (!hasPermissions) {
        print('Requesting permissions...');
        await HealthConnectFactory.requestPermissions(types, readOnly: readOnly);
        print('Permissions requested.');
      }

      print('Fetching changes token...');
      token = await HealthConnectFactory.getChangesToken(types);
      print('Token: $token');

      print('Fetching changes...');
      var changes = await HealthConnectFactory.getChanges(token);
      print('Changes: $changes');

      var startTime = DateTime.now().subtract(const Duration(days: 4));
      var endTime = DateTime.now();

      print('Fetching records...');
      final requests = <Future>[];
      Map<String, dynamic> typePoints = {};
      for (var type in types) {
        requests.add(HealthConnectFactory.getRecord(
          type: type,
          startTime: startTime,
          endTime: endTime,
        ).then((value) {
          typePoints.addAll({type.name: value});
          print('Fetched ${type.name}: $value');
        }));
      }
      await Future.wait(requests);

      resultText = '$typePoints';
      print('All records fetched: $resultText');
    } catch (e) {
      resultText = e.toString();
      print('Error fetching data: $resultText');
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('의사 스크린', style: TextStyle(color: Colors.black, fontSize: 24)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _fetchHealthData(context),
              child: const Text('Fetch Health Data'),
            ),
          ],
        ),
      ),
    );
  }
}
