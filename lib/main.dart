import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/splash.dart';
import 'package:season3_team1_mainproject/vm/loginGetx.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); // .env 파일 로드
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 기본 플러터로 테마 관리할때 쓰는것.
  // ThemeMode _themeMode = ThemeMode.system;

  // _changeThemeMode(ThemeMode themeMode) {
  //   setState(() {
  //     _themeMode = themeMode;
  //   });
  // }

  static const Color seedcolor = Color(0xFF01479D);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'NotoSansKR-Regular',
            brightness: Brightness.light,
            useMaterial3: true,
            colorSchemeSeed: seedcolor,
          ),
          darkTheme: ThemeData(
              fontFamily: 'NotoSansKR-Regular',
              brightness: Brightness.dark,
              useMaterial3: true,
              colorSchemeSeed: seedcolor),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
          },
        );
      },
    );
  }
}
