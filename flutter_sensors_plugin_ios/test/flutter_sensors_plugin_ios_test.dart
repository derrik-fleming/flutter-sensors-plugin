import 'package:flutter/services.dart';
import 'package:flutter_sensors_plugin_ios/flutter_sensors_plugin_ios.dart';
import 'package:flutter_sensors_plugin_platform_interface/flutter_sensors_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSensorsPluginIOS', () {
    const kPlatformName = 'iOS';
    late FlutterSensorsPluginIOS flutterSensorsPlugin;
    late List<MethodCall> log;

    setUp(() async {
      flutterSensorsPlugin = FlutterSensorsPluginIOS();

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
      FlutterSensorsPluginIOS.registerWith();
      expect(
        FlutterSensorsPluginPlatform.instance,
        isA<FlutterSensorsPluginIOS>(),
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
