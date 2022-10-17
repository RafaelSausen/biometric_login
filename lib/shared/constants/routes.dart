import 'package:biometric_login/modules/biometric/screens/biometric_login_test_view.dart';
import 'package:biometric_login/modules/biometric/screens/hello_view.dart';
import 'package:biometric_login/modules/biometric/screens/login_view.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/login': (_) => const LoginView(),
    '/hello': (_) => const HelloView(),
    '/test': (_) => const BiometricLoginTestView(),
  };

  static String initial = '/login';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
