import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangerProvider>(builder: (context, themeMode, child) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => themeMode.setThemeMode(ThemeMode.light),
            child: Container(
              width: 50,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: themeMode.themeMode == ThemeMode.light
                    ? AppColor.foregroundColorLight
                    : AppColor.foregroundColorDark,
              ),
              child: Icon(
                Icons.light_mode,
                color: themeMode.themeMode == ThemeMode.light
                    ? AppColor.componentColor
                    : AppColor.unselectedIconColorDark,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => themeMode.setThemeMode(ThemeMode.dark),
            child: Container(
              width: 50,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: themeMode.themeMode == ThemeMode.light
                    ? AppColor.foregroundColorLight
                    : AppColor.foregroundColorDark,
              ),
              child: Icon(
                Icons.dark_mode,
                color: themeMode.themeMode == ThemeMode.dark
                    ? AppColor.componentColor
                    : AppColor.unselectedIconColorLight,
              ),
            ),
          ),
        ],
      );
    });
  }
}
