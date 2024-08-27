import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hanieum/utilities/app_pages.dart';
import 'package:hanieum/views/login/login_screen.dart';
import 'package:hanieum/views/root/root_screen.dart';
import 'bindings/root_binding.dart';

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    _init(context);

    return GetMaterialApp(
      title: "Hanieum",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: initialRoute,
      home: LoginScreen(),
      getPages: [
        GetPage(
            name: '/', page: () => const RootScreen(), binding: RootBinding()),
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            binding: RootBinding()),
      ],
      initialBinding: RootBinding(),
    );
  }

  Future<void> _init(BuildContext context) async {
    FlutterNativeSplash.remove();
  }
}