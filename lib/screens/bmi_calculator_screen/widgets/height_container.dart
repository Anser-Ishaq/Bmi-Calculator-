import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:bmi_calculator/provider/unit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeightContainer extends StatefulWidget {
  const HeightContainer({
    super.key,
    required this.minHeight,
    required this.maxHeight,
    required this.onChanged,
  });

  final double minHeight;
  final double maxHeight;
  final ValueChanged<double> onChanged;

  @override
  State<HeightContainer> createState() => _HeightContainerState();
}

class _HeightContainerState extends State<HeightContainer> {
  late TextEditingController _feetController;
  late TextEditingController _inchesController;
  late TextEditingController _metersController;
  late TextEditingController _centimetersController;

  bool _isFeetValid = true;
  bool _isInchesValid = true;
  bool _isMetersValid = true;
  bool _isCentimetersValid = true;

  @override
  void initState() {
    super.initState();
    _feetController = TextEditingController();
    _inchesController = TextEditingController();
    _metersController = TextEditingController();
    _centimetersController = TextEditingController();

    _feetController.addListener(_updateSliderFromFeet);
    _inchesController.addListener(_updateSliderFromInches);
    _metersController.addListener(_updateSliderFromMeters);
    _centimetersController.addListener(_updateSliderFromCentimeters);
  }

  @override
  void dispose() {
    _feetController.removeListener(_updateSliderFromFeet);
    _inchesController.removeListener(_updateSliderFromInches);
    _metersController.removeListener(_updateSliderFromMeters);
    _centimetersController.removeListener(_updateSliderFromCentimeters);
    _feetController.dispose();
    _inchesController.dispose();
    _metersController.dispose();
    _centimetersController.dispose();
    super.dispose();
  }

  List<Widget> _buildFeetInput() {
    return [
      SizedBox(
        width: 25,
        height: 25,
        child: TextField(
          controller: _feetController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _isFeetValid ? AppColor.grey : Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 22 / 12,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            counterText: '',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.componentColor,
              ),
            ),
          ),
          maxLength: 2,
          cursorHeight: 25,
          cursorColor: AppColor.componentColor,
          expands: true,
          maxLines: null,
          onChanged: (value) {
            final doubleValue = double.tryParse(value);
            setState(() {
              _isFeetValid =
                  doubleValue != null && doubleValue >= 0 && doubleValue <= 12;
            });
          },
        ),
      ),
      Text(
        'ft',
        style: TextStyle(
          color: AppColor.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        width: 25,
        height: 25,
        child: TextField(
          controller: _inchesController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _isInchesValid ? AppColor.grey : Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 22 / 12,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            counterText: '',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.componentColor,
              ),
            ),
          ),
          maxLength: 2,
          cursorHeight: 25,
          cursorColor: AppColor.componentColor,
          expands: true,
          maxLines: null,
          onChanged: (value) {
            final doubleValue = double.tryParse(value);
            setState(() {
              _isInchesValid =
                  doubleValue != null && doubleValue >= 0 && doubleValue <= 12;
            });
          },
        ),
      ),
      Text(
        'in',
        style: TextStyle(
          color: AppColor.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  List<Widget> _buildMeterInput() {
    return [
      SizedBox(
        width: 40,
        height: 25,
        child: TextField(
          controller: _metersController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _isMetersValid ? AppColor.grey : Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 22 / 12,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
            counterText: '',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.componentColor,
              ),
            ),
          ),
          maxLength: 4,
          cursorHeight: 25,
          cursorColor: AppColor.componentColor,
          expands: true,
          maxLines: null,
          onChanged: (value) {
            final doubleValue = double.tryParse(value);
            setState(() {
              _isMetersValid =
                  doubleValue != null && doubleValue >= 0 && doubleValue <= 4.0;
            });
          },
        ),
      ),
      Text(
        'm',
        style: TextStyle(
          color: AppColor.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  List<Widget> _buildCentiMeterInput() {
    return [
      SizedBox(
        width: 37,
        height: 25,
        child: TextField(
          controller: _centimetersController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _isCentimetersValid ? AppColor.grey : Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 22 / 12,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            counterText: '',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.componentColor,
              ),
            ),
          ),
          maxLength: 3,
          cursorHeight: 25,
          cursorColor: AppColor.componentColor,
          expands: true,
          maxLines: null,
          onChanged: (value) {
            final doubleValue = double.tryParse(value);
            setState(() {
              _isCentimetersValid =
                  doubleValue != null && doubleValue >= 0 && doubleValue <= 366;
            });
          },
        ),
      ),
      Text(
        'cm',
        style: TextStyle(
          color: AppColor.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  void _sliderToTextfield(String unit, double value) {
    switch (unit) {
      case 'cm':
        _centimetersController.text = value.toStringAsFixed(0);
        break;
      case 'm':
        _metersController.text = value.toStringAsFixed(2);
        break;
      case 'ft':
        int feet = value.floor();
        int inches = ((value - feet) * 12).round();

        _feetController.text = feet.toString();
        _inchesController.text = inches.toString();
        break;
    }
  }

  void _updateSliderFromFeet() {
    final feet = double.tryParse(_feetController.text) ?? 0;
    final inches = double.tryParse(_inchesController.text) ?? 0;
    final totalFeet = feet + inches / 12;
    _updateSliderValue(totalFeet);
  }

  void _updateSliderFromInches() {
    final feet = double.tryParse(_feetController.text) ?? 0;
    final inches = double.tryParse(_inchesController.text) ?? 0;
    final totalFeet = feet + inches / 12;
    _updateSliderValue(totalFeet);
  }

  void _updateSliderFromMeters() {
    final meters = double.tryParse(_metersController.text) ?? 0;
    _updateSliderValue(meters);
  }

  void _updateSliderFromCentimeters() {
    final centimeters = double.tryParse(_centimetersController.text) ?? 0;
    _updateSliderValue(centimeters);
  }

  void _updateSliderValue(double value) {
    final unitProvider = Provider.of<UnitProvider>(context, listen: false);
    unitProvider.setDefaultHeight(value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangerProvider>(
      builder: (context, themeChangerProvider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeChangerProvider.themeMode == ThemeMode.light
                ? AppColor.foregroundColorLight
                : AppColor.foregroundColorDark,
          ),
          child:
              Consumer<UnitProvider>(builder: (context, unitProvider, child) {
            return Column(
              children: [
                Text(
                  'Height',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey,
                    height: 22.5 / 15,
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: unitProvider.heightUnit == 'cm'
                        ? _buildCentiMeterInput()
                        : unitProvider.heightUnit == 'm'
                            ? _buildMeterInput()
                            : _buildFeetInput(),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 15,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8.5,
                              disabledThumbRadius: 8.5,
                              elevation: 0,
                              pressedElevation: 0,
                            ),
                            activeTrackColor: AppColor.componentColor,
                            thumbColor: AppColor.componentColor,
                            inactiveTrackColor: AppColor.backgroundColorLight,
                            tickMarkShape: SliderTickMarkShape.noTickMark,
                            valueIndicatorColor: AppColor.componentColor,
                            overlayColor: Colors.transparent,
                            valueIndicatorTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              value: unitProvider.defaultHeight,
                              min: widget.minHeight,
                              max: widget.maxHeight,
                              label: '${unitProvider.defaultHeight}',
                              onChanged: (value) {
                                _sliderToTextfield(
                                    unitProvider.heightUnit, value);
                                double formattedValue =
                                    double.parse(value.toStringAsFixed(2));
                                unitProvider.setDefaultHeight(formattedValue);
                                widget.onChanged(formattedValue);
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: _drawLabels(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _drawLabels() {
    double stepSize = (widget.maxHeight - widget.minHeight) / 6;
    List<Widget> labels = List.generate(
      7,
      (idx) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                border: Border.all(
                  color: AppColor.grey,
                  width: 1,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 18,
              margin: const EdgeInsets.only(right: 15),
              child: Center(
                child: Text(
                  widget.minHeight == 0 && widget.maxHeight == 4
                      ? (widget.maxHeight - stepSize * idx).toStringAsFixed(2)
                      : (widget.maxHeight - stepSize * idx).toStringAsFixed(0),
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels,
    );
  }
}
