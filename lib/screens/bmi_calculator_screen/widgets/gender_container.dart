import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderContainer extends StatefulWidget {
  const GenderContainer({
    super.key,
    required this.gender,
    required this.icon,
    required this.isSelected,
    required this.onSelect,
  });

  final String gender;
  final IconData icon;
  final bool isSelected;
  final void Function(String gender) onSelect;

  @override
  State<GenderContainer> createState() => _GenderContainerState();
}

class _GenderContainerState extends State<GenderContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangerProvider>(
        builder: (context, themeChangerProvider, child) {
      return GestureDetector(
        onTap: () {
          widget.onSelect(widget.gender);
        },
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.isSelected
                ? AppColor.componentColor
                : themeChangerProvider.themeMode == ThemeMode.light
                    ? AppColor.foregroundColorLight
                    : AppColor.foregroundColorDark,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.isSelected
                    ? Colors.white
                    : themeChangerProvider.themeMode == ThemeMode.dark
                        ? AppColor.textColorDark
                        : AppColor.textColorLight,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                widget.gender,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.isSelected ||
                          themeChangerProvider.themeMode == ThemeMode.dark
                      ? AppColor.textColorDark
                      : AppColor.textColorLight,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
