import 'package:bmi_calculator/constants/colors/app_color.dart';
import 'package:bmi_calculator/provider/theme_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ValueContainer extends StatefulWidget {
  const ValueContainer({
    super.key,
    required this.title,
    required this.textEditingController,
    required this.defaultValue,
    required this.minValue,
    required this.maxValue,
  });

  final String title;
  final TextEditingController textEditingController;
  final int defaultValue;
  final int minValue;
  final int maxValue;

  @override
  State<ValueContainer> createState() => _ValueContainerState();
}

class _ValueContainerState extends State<ValueContainer> {
  late TextEditingController _valueController;
  late FocusNode _focusNode;
  int _value = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _valueController = widget.textEditingController;
    _focusNode = FocusNode();
    _valueController.text = widget.defaultValue.toString();
    _value = int.tryParse(_valueController.text) ?? 0;
  }

  @override
  void didUpdateWidget(ValueContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultValue != widget.defaultValue) {
      setState(() {
        _valueController.text = widget.defaultValue.toString();
        _value = widget.defaultValue;
      });
    }
  }

  void _updateValue(int delta) {
    setState(() {
      _value = (_value + delta).clamp(widget.minValue, widget.maxValue);
      _valueController.text = _value.toString();
    });
  }

  void _startUpdatingValue(int delta) {
    _updateValue(delta);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _updateValue(delta);
    });
  }

  void _stopUpdatingValue() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangerProvider>(
      builder: (context, themeChangerProvider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeChangerProvider.themeMode == ThemeMode.light
                ? AppColor.foregroundColorLight
                : AppColor.foregroundColorDark,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey,
                  height: 22.5 / 15,
                ),
              ),
              SizedBox(
                height: 65,
                child: TextField(
                  controller: _valueController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.w600,
                    height: 96 / 64,
                    color: themeChangerProvider.themeMode == ThemeMode.light
                        ? AppColor.textColorLight
                        : AppColor.textColorDark,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  cursorColor: AppColor.componentColor,
                  onChanged: (value) {
                    setState(() {
                      _value = int.tryParse(value) ?? widget.minValue;
                      if (_value < widget.minValue) _value = widget.minValue;
                      if (_value > widget.maxValue) _value = widget.maxValue;
                      _valueController.text = _value.toString();
                    });
                  },
                  onTap: () {
                    _focusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _counterBox(Icons.remove, -1),
                  _counterBox(Icons.add, 1),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _counterBox(IconData iconData, int delta) {
    return GestureDetector(
      onTap: () => _updateValue(delta),
      onLongPress: () => _startUpdatingValue(delta),
      onLongPressEnd: (_) => _stopUpdatingValue(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.componentColor,
        ),
        child: Center(
          child: Icon(
            iconData,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }
}
