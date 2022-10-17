import 'package:biometric_login/shared/constants/routes.dart';
import 'package:biometric_login/shared/constants/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      navigatorKey: Routes.navigatorKey,
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      routes: Routes.list,
      initialRoute: Routes.initial,
    );
  }
}
