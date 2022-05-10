import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSamplePlugin {
  static const MethodChannel _channel = MethodChannel('flutter_sample_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
