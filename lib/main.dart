import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:bmi_calculator/provider/unit_provider.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/bmi_calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChangerProvider()),
        ChangeNotifierProvider(create: (_) => UnitProvider()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final themeChanger = Provider.of<ThemeChangerProvider>(context);
          if (themeChanger.themeMode == ThemeMode.light) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: AppColor.backgroundColorLight,
                systemNavigationBarDividerColor: AppColor.backgroundColorLight,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                statusBarColor: AppColor.backgroundColorLight,
                statusBarIconBrightness: Brightness.dark,
              ),
            );
          } else {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: AppColor.backgroundColorDark,
                systemNavigationBarDividerColor: AppColor.backgroundColorDark,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                statusBarColor: AppColor.backgroundColorDark,
                statusBarIconBrightness: Brightness.light,
              ),
            );
          }

          return MaterialApp(
            title: 'BMI Calculator',
            themeMode: themeChanger.themeMode,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: true,
              fontFamily: 'Poppins',
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
              fontFamily: 'Poppins',
            ),
            home: const BmiCalculatorScreen(),
          );
        },
      ),
    );
  }
}
