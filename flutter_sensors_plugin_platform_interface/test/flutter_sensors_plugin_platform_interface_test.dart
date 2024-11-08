import 'package:flutter_sensors_plugin_platform_interface/flutter_sensors_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class FlutterSensorsPluginMock extends FlutterSensorsPluginPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('FlutterSensorsPluginPlatformInterface', () {
    late FlutterSensorsPluginPlatform flutterSensorsPluginPlatform;

    setUp(() {
      flutterSensorsPluginPlatform = FlutterSensorsPluginMock();
      FlutterSensorsPluginPlatform.instance = flutterSensorsPluginPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await FlutterSensorsPluginPlatform.instance.getPlatformName(),
          equals(FlutterSensorsPluginMock.mockPlatformName),
        );
      });
    });
  });
}
