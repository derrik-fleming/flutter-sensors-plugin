import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sensors_plugin_platform_interface/flutter_sensors_plugin_platform_interface.dart';

/// The Android implementation of [FlutterSensorsPluginPlatform].
class FlutterSensorsPluginAndroid extends FlutterSensorsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sensors_plugin_android');

  /// Registers this class as the default instance of
  /// [FlutterSensorsPluginPlatform]
  static void registerWith() {
    FlutterSensorsPluginPlatform.instance = FlutterSensorsPluginAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
