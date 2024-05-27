import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../viewModels/home/wear_os_connectivity_viewmodel.dart';
import '../base/base_screen.dart';

class WearOsConnectivityScreen extends BaseScreen<WearOsConnectivityViewModel> {
  WearOsConnectivityScreen({super.key});

  @override
  final WearOsConnectivityViewModel viewModel = Get.find<WearOsConnectivityViewModel>();

  @override
  Widget buildBody(BuildContext context) {
    return const HealthDataPage();
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
            children: const <Widget>[
              HealthDataContainer(),
              // 다른 컨테이너 추가 가능
            ],
          ),
        ),
      ],
    );
  }
}

class HealthDataContainer extends StatefulWidget {
  const HealthDataContainer({super.key});

  @override
  _HealthDataContainerState createState() => _HealthDataContainerState();
}

class _HealthDataContainerState extends State<HealthDataContainer> {
  final List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.ExerciseSession,
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: _checkApiSupport,
              child: const Text('isApiSupported'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isAvailable();
                setState(() {
                  resultText = 'isAvailable: $result';
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
              },
              child: const Text('Check installed'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.openHealthConnectSettings();
                  setState(() {
                    resultText = 'Settings activity started';
                  });
                } catch (e) {
                  setState(() {
                    resultText = e.toString();
                  });
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
              },
              child: const Text('Open Health Connect Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                var hasPermission = await HealthConnectFactory.hasPermissions(
                  types,
                  readOnly: readOnly,
                );
                // If permissions are not granted, request them
                if (!hasPermission) {
                  // Assuming we have a method to handle permission requests
                  await requestPermissions(types);
                  // Re-check permissions after requesting
                  hasPermission = await HealthConnectFactory.hasPermissions(
                    types,
                    readOnly: readOnly,
                  );
                }
                // Update the state and show the result
                setState(() {
                  resultText = 'hasPermissions: $hasPermission';
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
              },
              child: const Text('Has Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  token = await HealthConnectFactory.getChangesToken(types);
                  setState(() {
                    resultText = 'token: $token';
                  });
                } catch (e) {
                  setState(() {
                    resultText = e.toString();
                  });
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
              },
              child: const Text('Get Changes Token'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await HealthConnectFactory.getChanges(token);
                  setState(() {
                    resultText = 'changes: $result';
                  });
                } catch (e) {
                  setState(() {
                    resultText = e.toString();
                  });
                }
                ScaffoldMessenger.of(context). showSnackBar(SnackBar(content: Text(resultText)));
              },
              child: const Text('Get Changes'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await HealthConnectFactory.requestPermissions(
                    types,
                    readOnly: readOnly,
                  );
                  setState(() {
                    resultText = 'requestPermissions: $result';
                  });
                } catch (e) {
                  setState(() {
                    resultText = e.toString();
                  });
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () => _fetchHealthData(context),
              child: const Text('Get Record'),
            ),
            Text(resultText),
          ],
        ),
      ),
    );
  }
  bool readOnly = true;
  String resultText = '';

  String token = '';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      setState(() {
        resultText = 'Health permission granted.';
      });
    } else {
      setState(() {
        resultText = 'Health permission denied.';
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
    _checkApiSupport();
  }

  Future<void> requestPermissions(List<HealthConnectDataType> types) async {
    // Convert HealthConnectDataType to Permission
    List<Permission> permissions = types.map((type) {
      switch (type) {
        case HealthConnectDataType.Steps:
          return Permission.activityRecognition;
      // Map other data types to their corresponding permissions
        default:
          return Permission.activityRecognition;
      }
    }).toList();

    // Request permissions for all items in the list
    await Future.wait(permissions.map((permission) => permission.request()).toList());

    // Check the status of each permission
    bool allGranted = true;
    for (Permission permission in permissions) {
      if (await permission.status.isDenied) {
        allGranted = false;
        break;
      }
    }

    // Use setState to update your UI and possibly notify the user
    setState(() {
      if (allGranted) {
        resultText = 'All permissions granted.';
      } else {
        resultText = 'Not all permissions were granted.';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
  }

  Future<void> _checkApiSupport() async {
    try {
      var result = await HealthConnectFactory.isApiSupported();
      setState(() {
        resultText = 'isApiSupported: $result';
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
    } catch (e) {
      setState(() {
        resultText = e.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
    }
  }

  Future<void> _fetchHealthData(BuildContext context) async {
    try {
      var startTime = DateTime.now().subtract(const Duration(days: 4));
      var endTime = DateTime.now();

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

      setState(() {
        resultText = '$typePoints';
      });
      print('All records fetched: $resultText');
    } catch (e) {
      setState(() {
        resultText = e.toString();
      });
      print('Error fetching data: $resultText');
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultText)));
  }
}
