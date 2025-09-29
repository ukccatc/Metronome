/// Reusable utility methods
/// This file contains all utility methods used throughout the application

import 'dart:math' as math;

class AppMethods {
  // BPM calculation methods
  static int calculateBpmFromInterval(Duration interval) {
    if (interval.inMilliseconds == 0) return 0;
    return (60000 / interval.inMilliseconds).round();
  }
  
  static Duration calculateIntervalFromBpm(int bpm) {
    if (bpm <= 0) return Duration.zero;
    return Duration(milliseconds: (60000 / bpm).round());
  }
  
  // Volume conversion methods
  static double linearToDecibels(double linear) {
    if (linear <= 0) return -96.0; // Minimum decibel value
    return 20 * math.log(linear) / math.ln10;
  }
  
  static double decibelsToLinear(double decibels) {
    if (decibels <= -96.0) return 0.0;
    return math.pow(10, decibels / 20).toDouble();
  }
  
  // Validation methods
  static bool isValidBpm(int bpm) {
    return bpm >= 40 && bpm <= 200;
  }
  
  static bool isValidTimeSignature(int signature) {
    return signature >= 2 && signature <= 8;
  }
  
  static bool isValidVolume(double volume) {
    return volume >= 0.0 && volume <= 1.0;
  }
  
  // Formatting methods
  static String formatBpm(int bpm) {
    return '$bpm BPM';
  }
  
  static String formatTimeSignature(int signature) {
    return '$signature/4';
  }
  
  static String formatVolume(double volume) {
    return '${(volume * 100).round()}%';
  }
  
  // Math utility methods
  static double clamp(double value, double min, double max) {
    return math.max(min, math.min(max, value));
  }
  
  static int clampInt(int value, int min, int max) {
    return math.max(min, math.min(max, value));
  }
  
  // Animation easing methods
  static double easeInOutCubic(double t) {
    return t < 0.5 ? 4 * t * t * t : 1 - math.pow(-2 * t + 2, 3) / 2;
  }
  
  static double easeOutBounce(double t) {
    const double n1 = 7.5625;
    const double d1 = 2.75;
    
    if (t < 1 / d1) {
      return n1 * t * t;
    } else if (t < 2 / d1) {
      return n1 * (t -= 1.5 / d1) * t + 0.75;
    } else if (t < 2.5 / d1) {
      return n1 * (t -= 2.25 / d1) * t + 0.9375;
    } else {
      return n1 * (t -= 2.625 / d1) * t + 0.984375;
    }
  }
  
  // Private constructor to prevent instantiation
  AppMethods._();
}
