import 'package:flutter/material.dart';
import 'dart:math';

class UnitProvider extends ChangeNotifier {
  String _heightUnit = 'cm';
  String _weightUnit = 'kg';
  double _defaultHeight = 120;
  bool _isLoading = false;

  String get heightUnit => _heightUnit;
  String get weightUnit => _weightUnit;
  double get defaultHeight => _defaultHeight;
  bool get isLoading => _isLoading;

  void setHeightUnit(String unit) {
    _heightUnit = unit;
    switch (_heightUnit) {
      case 'cm':
        _defaultHeight = 120;
        break;
      case 'm':
        _defaultHeight = 1.2;
        break;
      case 'ft':
        _defaultHeight = 3.9;
        break;
      case 'in':
        _defaultHeight = 30;
        break;
    }
    notifyListeners();
  }

  void setWeightUnit(String unit) {
    _weightUnit = unit;
    notifyListeners();
  }

  void setDefaultHeight(double height) {
    _defaultHeight = height;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  double convertHeightToCm(double height, String unit) {
    switch (unit) {
      case 'm':
        return height * 100;
      case 'ft':
        return height * 30.48;
      default: 
        return height;
    }
  }

  double convertWeightToKg(double weight, String unit) {
    switch (unit) {
      case 'lb':
        return weight * 0.453592;
      default:
        return weight;
    }
  }

  double calculateBMI(double height, double weight, int age) {
    double heightCm = convertHeightToCm(height, heightUnit);
    double weightKg = convertWeightToKg(weight, weightUnit);

    double heightInMeters = heightCm / 100;

    if (age >= 2 && age <= 19) {
      double bmi = weightKg / pow(heightInMeters, 2);
      return bmi;
    } else {
      return weightKg / pow(heightInMeters, 2);
    }
  }
}
