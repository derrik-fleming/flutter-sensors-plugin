import 'package:flutter_sensors_plugin/flutter_sensors_plugin.dart';
import 'package:flutter_sensors_plugin_platform_interface/flutter_sensors_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSensorsPluginPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FlutterSensorsPluginPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSensorsPlugin', () {
    late FlutterSensorsPluginPlatform flutterSensorsPluginPlatform;

    setUp(() {
      flutterSensorsPluginPlatform = MockFlutterSensorsPluginPlatform();
      FlutterSensorsPluginPlatform.instance = flutterSensorsPluginPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => flutterSensorsPluginPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => flutterSensorsPluginPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
