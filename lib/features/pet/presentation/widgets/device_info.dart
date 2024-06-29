// presentation/widget/device_info_service.dart
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:flutter/widgets.dart';

class DeviceInfo {
  DeviceInfo._();

  static bool isTabletDevice() {
    final data = MediaQuery.of(AppNavigator.navigatorKey.currentState!.context);
    return data.size.shortestSide >= 600;
  }

  static bool isLandScape() {
    final data = MediaQuery.of(AppNavigator.navigatorKey.currentState!.context);
    return data.orientation == Orientation.landscape;
  }
}
