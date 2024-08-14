import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitContainer extends StatefulWidget {
  const UnitContainer({
    super.key,
    required this.unitText,
    required this.unit1,
    required this.unit2,
    this.unit3,
    this.unit4,
    required this.onUnitSelected,
  });

  final String unitText;
  final String unit1;
  final String unit2;
  final String? unit3;
  final String? unit4;
  final void Function(String selectedUnit) onUnitSelected;

  @override
  State<UnitContainer> createState() => _UnitContainerState();
}

class _UnitContainerState extends State<UnitContainer> {
  int selectedIndex = 0;

  Color getUnitBoxColor(int index) {
    return selectedIndex == index
        ? AppColor.componentColor
        : Colors.transparent;
  }

  Color getUnitBoxTextColor(int index, themeMode) {
    return selectedIndex == index || themeMode == ThemeMode.dark
        ? AppColor.textColorDark
        : AppColor.textColorLight;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangerProvider>(
        builder: (context, themeChangerProvider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 17),
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeChangerProvider.themeMode == ThemeMode.light
              ? AppColor.foregroundColorLight
              : AppColor.foregroundColorDark,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.unitText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: themeChangerProvider.themeMode == ThemeMode.light
                        ? AppColor.textColorLight
                        : AppColor.textColorDark,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                widget.onUnitSelected(widget.unit1);
              },
              child: _unitBox(
                  widget.unit1, getUnitBoxColor(0), getUnitBoxTextColor(0, themeChangerProvider.themeMode)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                widget.onUnitSelected(widget.unit2);
              },
              child: _unitBox(
                  widget.unit2, getUnitBoxColor(1), getUnitBoxTextColor(1, themeChangerProvider.themeMode)),
            ),
            widget.unit3 != null
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                      widget.onUnitSelected(widget.unit3!);
                    },
                    child: _unitBox(widget.unit3!, getUnitBoxColor(2),
                        getUnitBoxTextColor(2, themeChangerProvider.themeMode)),
                  )
                : const SizedBox.shrink(),
            widget.unit4 != null
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                      widget.onUnitSelected(widget.unit4!);
                    },
                    child: _unitBox(widget.unit4!, getUnitBoxColor(3),
                        getUnitBoxTextColor(3, themeChangerProvider.themeMode)),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }

  _unitBox(String unit, Color unitBoxColor, Color unitBoxTextColor) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: unitBoxColor,
      ),
      child: Center(
        child: Text(
          unit,
          style: TextStyle(
            fontSize: 17,
            color: unitBoxTextColor,
          ),
        ),
      ),
    );
  }
}
