import 'package:get/get.dart';
import '../constants/strings.dart';
import '../view/device_sync_screen.dart';
import '../view/dashboard_screen.dart';
import '../view/item_scanning_details_screen.dart';
import '../view/item_search_screen.dart';
import '../view/item_verification_screen.dart';
import '../view/license_verification_screen.dart';
import '../view/operation_input_screen.dart';
import '../view/settings_screen.dart';
import '../view/login_screen.dart';
import '../view/device_setup_screen.dart';
import '../view/scanning_screen.dart';
import '../view/search_operation_input_screen.dart';
import '../view/splash_screen.dart';

class Routes {
  Routes._();

  ///routes path
  static const String splashScreen = Strings.splashScreen;
  static const String mainScreen = Strings.mainScreen;
  static const String loginScreen = Strings.loginScreen;
  static const String scanningScreen = Strings.scanningScreen;
  static const String deviceSetUpScreen = Strings.deviceSetUpScreen;
  static const String deviceSyncScreen = Strings.deviceSyncScreen;
  static const String dashboardScreen = Strings.dashboardScreen;
  static const String operationInputScreen = Strings.operationInputScreen;
  static const String receiveScreen = Strings.receiveScreen;
  static const String cycleCountScreen = Strings.cycleCountOperationScreen;
  static const String itemSearchScreen = Strings.itemSearchOperationScreen;
  static const String itemVerificationScreen = Strings.itemVerificationScreen;
  static const String settingsScreen = Strings.settingsScreen;
  static const String searchOperationInputScreen = Strings.searchOperationInputScreen;
  static const String licenseVerificationScreen = Strings.licenseVerificationScreen;
  static const String itemScanningDetailsScreen = Strings.itemScanningDetailsScreen;

  ///routes list
  static final routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: scanningScreen, page: () => const ScanningScreen()),
    GetPage(name: deviceSetUpScreen, page: () => const DeviceSetUpScreen()),
    GetPage(name: deviceSyncScreen, page: () => const DeviceSyncScreen()),
    GetPage(name: dashboardScreen, page: () => const DashboardScreen()),
    GetPage(name: operationInputScreen, page: () => const OperationInputScreen()),
    GetPage(name: searchOperationInputScreen, page: () => const SearchOperationInputScreen()),
    GetPage(name: licenseVerificationScreen, page: () => const LicenseVerificationScreen()),
    GetPage(name: itemSearchScreen, page: () => const ItemSearchScreen()),
    GetPage(name: itemVerificationScreen, page: () => const ItemVerificationScreen()),
    GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: itemScanningDetailsScreen, page: () => const ItemScanningDetailsScreen())
  ];

}
