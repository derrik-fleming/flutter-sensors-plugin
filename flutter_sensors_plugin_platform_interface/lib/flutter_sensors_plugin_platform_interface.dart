import 'package:flutter_sensors_plugin_platform_interface/src/method_channel_flutter_sensors_plugin.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of flutter_sensors_plugin must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `FlutterSensorsPlugin`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [FlutterSensorsPluginPlatform]
///  methods.
abstract class FlutterSensorsPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterSensorsPluginPlatform.
  FlutterSensorsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSensorsPluginPlatform _instance =
      MethodChannelFlutterSensorsPlugin();

  /// The default instance of [FlutterSensorsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSensorsPlugin].
  static FlutterSensorsPluginPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterSensorsPluginPlatform] when they register
  /// themselves.
  static set instance(FlutterSensorsPluginPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();
}
