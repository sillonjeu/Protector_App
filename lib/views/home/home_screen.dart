import 'package:flutter/material.dart';
import '../../viewModels/home/home_viewmodel.dart';
import '../base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Center(
                  child: Text('X0E1F5GJ', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
              ),
              // 다른 컨테이너 추가 가능
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(8, (index) {
              // 상태에 따라 아이콘 변경
              IconData iconData = Icons.check_circle_outline;
              Color color = Colors.green;
              if (index % 3 == 1) {
                iconData = Icons.error_outline;
                color = Colors.red;
              }
              return Card(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(iconData, size: 50, color: color),
                      Text(
                        '상태 ${index + 1}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}