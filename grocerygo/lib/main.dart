import 'dart:io';

import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/service/my_http_overrides.dart';
import 'package:grocerygo/view/start/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

void loadingIndicator() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = primaryText
    ..backgroundColor = primary
    ..indicatorColor = Colors.yellow
    ..textColor = primaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GroceryGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: gilroyBold,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: false,
      ),
      home: const SplashView(),
      builder: (context, child) {
        // Tích hợp chỉ báo tải (loading indicator) vào giao diện ứng dụng
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
