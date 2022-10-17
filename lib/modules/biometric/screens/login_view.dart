import 'package:biometric_login/modules/biometric/services/biometric_login.dart';
import 'package:biometric_login/shared/components/rsb_button.dart';
import 'package:biometric_login/shared/components/rsb_snack_bar.dart';
import 'package:biometric_login/shared/constants/theme.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  RSBButton _buildLoginButton(BuildContext context) {
    return RSBButton(
      iconStart: Icons.login,
      iconEnd: Icons.fingerprint,
      text: "Enter",
      onPressed: () => _initSession(context),
    );
  }

  RSBButton _buildTestButton(BuildContext context) {
    return RSBButton(
      iconStart: Icons.check,
      text: "Test view",
      onPressed: () => _openTestView(context),
    );
  }

  _initSession(BuildContext context) async {
    BiometricLogin biometricLogin = BiometricLogin();

    bool canCheckBiometrics = await biometricLogin.checkBiometrics();
    if (!canCheckBiometrics) {
      RSBSnackBar().show(
        context: context,
        message: "Can't check biometrics",
        color: Colors.red,
      );
    }

    bool authenticated = await biometricLogin.authenticate();
    if (authenticated) {
      if (!mounted) return;
      Navigator.pushNamed(context, '/hello');
    }
  }

  _openTestView(BuildContext context) async {
    Navigator.pushNamed(context, '/test');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoginButton(context),
          _buildTestButton(context),
        ],
      ),
    );
  }
}
