import 'package:flutter/services.dart';
import 'package:flutter_sensors_plugin_android/flutter_sensors_plugin_android.dart';
import 'package:flutter_sensors_plugin_platform_interface/flutter_sensors_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSensorsPluginAndroid', () {
    const kPlatformName = 'Android';
    late FlutterSensorsPluginAndroid flutterSensorsPlugin;
    late List<MethodCall> log;

    setUp(() async {
      flutterSensorsPlugin = FlutterSensorsPluginAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        flutterSensorsPlugin.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        },
      );
    });

    test('can be registered', () {
      FlutterSensorsPluginAndroid.registerWith();
      expect(
        FlutterSensorsPluginPlatform.instance,
        isA<FlutterSensorsPluginAndroid>(),
      );
    });

    test('getPlatformName returns correct name', () async {
      final name = await flutterSensorsPlugin.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
