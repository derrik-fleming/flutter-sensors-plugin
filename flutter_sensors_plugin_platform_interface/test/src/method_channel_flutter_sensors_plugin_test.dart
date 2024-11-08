import 'package:flutter/services.dart';
import 'package:flutter_sensors_plugin_platform_interface/src/method_channel_flutter_sensors_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannelFlutterSensorsPlugin', () {
    late MethodChannelFlutterSensorsPlugin methodChannelFlutterSensorsPlugin;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelFlutterSensorsPlugin = MethodChannelFlutterSensorsPlugin();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannelFlutterSensorsPlugin.methodChannel,
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

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName =
          await methodChannelFlutterSensorsPlugin.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
