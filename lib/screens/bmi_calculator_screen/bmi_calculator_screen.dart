import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:bmi_calculator/provider/unit_provider.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/custom_button.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/gender_container.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/height_container.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/text_container.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/theme_selector.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/unit_container.dart';
import 'package:bmi_calculator/screens/bmi_calculator_screen/widgets/value_container.dart';
import 'package:bmi_calculator/screens/result_screen.dart/result_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final _weightTextEditingController = TextEditingController();
  final _ageTextEditingController = TextEditingController();
  double _selectedHeight = 0;

  String _selectedGender = 'Male';

  void _handleGenderSelect(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _weightTextEditingController.dispose();
    _ageTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChangerProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeChangerProvider.themeMode == ThemeMode.light
          ? AppColor.backgroundColorLight
          : AppColor.backgroundColorDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const ThemeSelector(),
              Column(
                children: [
                  TextContainer(
                    child: Text(
                      'Welcome \u{1F60A}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: themeChangerProvider.themeMode == ThemeMode.light
                            ? AppColor.textColorLight
                            : AppColor.textColorDark,
                        height: 22.5 / 15,
                      ),
                    ),
                  ),
                  TextContainer(
                    child: Text(
                      'BMI Calculator',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: themeChangerProvider.themeMode == ThemeMode.light
                            ? AppColor.textColorLight
                            : AppColor.textColorDark,
                        height: 36 / 24,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<UnitProvider>(
                builder: (context, unitProvider, child) {
                  return UnitContainer(
                    unitText: 'Height',
                    unit1: 'cm',
                    unit2: 'm',
                    // unit3: 'in',
                    unit4: 'ft',
                    onUnitSelected: (selectedUnit) {
                      unitProvider.setHeightUnit(selectedUnit);
                    },
                  );
                },
              ),
              Consumer<UnitProvider>(
                builder: (context, unitProvider, child) {
                  return UnitContainer(
                    unitText: 'Weight',
                    unit1: 'kg',
                    unit2: 'lb',
                    onUnitSelected: (selectedUnit) {
                      unitProvider.setWeightUnit(selectedUnit);
                    },
                  );
                },
              ),
              _genderBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Consumer<UnitProvider>(
                          builder: (context, unitProvider, child) {
                            double minHeight, maxHeight;

                            switch (unitProvider.heightUnit) {
                              case 'cm':
                                minHeight = 0;
                                maxHeight = 365.76;
                                break;
                              case 'm':
                                minHeight = 0;
                                maxHeight = 4;
                                break;
                              case 'in':
                                minHeight = 0;
                                maxHeight = 144;
                                break;
                              case 'ft':
                                minHeight = 0;
                                maxHeight = 12;
                                break;
                              default:
                                minHeight = 0;
                                maxHeight = 365.76;
                                break;
                            }

                            return HeightContainer(
                              minHeight: minHeight,
                              maxHeight: maxHeight,
                              onChanged: (height) {
                                _selectedHeight = height;
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<UnitProvider>(
                              builder: (context, unitProvider, child) {
                                return ValueContainer(
                                  title: 'Weight',
                                  textEditingController:
                                      _weightTextEditingController,
                                  defaultValue: unitProvider.weightUnit == 'lb'
                                      ? 150
                                      : 60,
                                  minValue: 0,
                                  maxValue: unitProvider.weightUnit == 'lb'
                                      ? 661
                                      : 300,
                                );
                              },
                            ),
                            ValueContainer(
                              title: 'Age',
                              textEditingController: _ageTextEditingController,
                              defaultValue: 25,
                              minValue: 0,
                              maxValue: 120,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<UnitProvider>(
                builder: (context, unitProvider, child) {
                  return CustomButton(
                    text: 'Lets Go',
                    onPressed: () async {
                      unitProvider.setIsLoading(true);
                      if (kDebugMode) print('ok');
                      double height = _selectedHeight == 0
                          ? unitProvider.defaultHeight
                          : _selectedHeight;
                      double weight =
                          double.parse(_weightTextEditingController.text);
                      int age = int.parse(_ageTextEditingController.text);

                      double bmi =
                          unitProvider.calculateBMI(height, weight, age);

                      if (kDebugMode) {
                        print('Height: $height,   Weight: $weight,  Age: $age');
                      }

                      if (kDebugMode) print(bmi);
                      if (kDebugMode) print(bmi.toStringAsFixed(1));

                      unitProvider.setIsLoading(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                              bmi: bmi, age: age, gender: _selectedGender),
                        ),
                      );
                    },
                    isLoading: unitProvider.isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget spacer() {
    return const SizedBox(
      height: 15,
    );
  }

  Widget _genderBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GenderContainer(
              gender: 'Male',
              icon: Icons.male,
              isSelected: _selectedGender == 'Male',
              onSelect: _handleGenderSelect,
            ),
          ),
          Expanded(
            child: GenderContainer(
              gender: 'Female',
              icon: Icons.female,
              isSelected: _selectedGender == 'Female',
              onSelect: _handleGenderSelect,
            ),
          ),
        ],
      ),
    );
  }
}
