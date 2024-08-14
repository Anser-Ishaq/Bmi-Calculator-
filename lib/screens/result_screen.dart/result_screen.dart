import 'dart:io';

import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/custom_button.dart';
import 'package:bmi_calculator/screens/result_screen.dart/data/percentile_calculator.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key, required this.bmi, required this.age, required this.gender});

  final double bmi;
  final int age;
  final String gender;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  String getStatus() {
    if (widget.age >= 2 && widget.age <= 19) {
      return PercentileCalculator.getWeightPercentile(
          widget.bmi, widget.age, widget.gender);
    } else {
      if (widget.bmi < 18.5) {
        return 'Underweight';
      } else if (widget.bmi >= 18.5 && widget.bmi < 25) {
        return 'Normal';
      } else if (widget.bmi >= 25 && widget.bmi < 30) {
        return 'Overweight';
      } else {
        return 'Obese';
      }
    }
  }

  double calculatePercentileProgress() {
    const double minBmi = 0;
    const double maxBmi = 40;
    return ((widget.bmi - minBmi) / (maxBmi - minBmi)).clamp(0.0, 1.0);
  }

  Future<void> _saveScreenshot() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      final bytes = image.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(bytes);
      if (result != null && result['isSuccess']) {
        _showSnackBar(
            'Screenshot saved to gallery!', Colors.green, Colors.white);
      } else {
        _showSnackBar('Failed to save screenshot.', Colors.red, Colors.white);
      }
    }
  }

  Future<void> _shareScreenshot() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = path.join(directory.path, fileName);
      final file = File(filePath);
      await file.writeAsBytes(image.buffer.asUint8List());
      Share.shareXFiles(
        [XFile(filePath)],
        text: 'Check out my BMI result!',
      );
    } else {
      _showSnackBar('Failed to capture screenshot.', Colors.red, Colors.white);
    }
  }

  void _showSnackBar(String message, Color backgroundColor, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChangerProvider = Provider.of<ThemeChangerProvider>(context);
    double progress = calculatePercentileProgress();

    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        backgroundColor: themeChangerProvider.themeMode == ThemeMode.light
            ? AppColor.backgroundColorLight
            : AppColor.backgroundColorDark,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Your BMI is',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 36 / 24,
                          color: AppColor.componentColor),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(26),
                  child: CircularPercentIndicator(
                    radius: (MediaQuery.of(context).size.width - 90) / 2,
                    lineWidth: 27,
                    percent: progress,
                    progressColor: AppColor.componentColor,
                    backgroundColor:
                        themeChangerProvider.themeMode == ThemeMode.light
                            ? AppColor.foregroundColorLight
                            : AppColor.foregroundColorDark,
                    startAngle: 180,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 1500,
                    center: Text(
                      widget.bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w600,
                        height: 150 / 100,
                        color: AppColor.componentColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      getStatus(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          height: 45 / 30,
                          color: AppColor.componentColor),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeChangerProvider.themeMode == ThemeMode.light
                        ? AppColor.foregroundColorLight
                        : AppColor.foregroundColorDark,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Underweight = ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: '<18.5\n',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: 'Normal weight = ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: '18.5–24.9\n',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: 'Overweight = ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: '25–29.9\n',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: 'Obesity = ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                        TextSpan(
                          text: 'BMI of 30 or greater',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                            color: themeChangerProvider.themeMode ==
                                    ThemeMode.light
                                ? AppColor.textColorLight
                                : AppColor.textColorDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _actionButton(
                          title: 'Save',
                          icon: Icons.save,
                          onTap: _saveScreenshot,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _actionButton(
                          title: 'Share',
                          icon: Icons.share,
                          onTap: _shareScreenshot,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CustomButton(
                    text: 'Go Back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.componentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColor.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
