import 'package:biometric_login/modules/biometric/services/biometric_login.dart';
import 'package:biometric_login/shared/components/return_button.dart';
import 'package:biometric_login/shared/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricLoginTestView extends StatefulWidget {
  const BiometricLoginTestView({Key? key}) : super(key: key);

  @override
  State<BiometricLoginTestView> createState() => _BiometricLoginTestViewState();
}

class _BiometricLoginTestViewState extends State<BiometricLoginTestView> {
  BiometricLogin biometricLogin = BiometricLogin();
  SupportState _supportState = SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  double dividerHeight = 25;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    await biometricLogin.initialize();
    setState(() {
      _supportState = biometricLogin.supportState;
    });
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;

    canCheckBiometrics = await biometricLogin.checkBiometrics();

    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;

    availableBiometrics = await biometricLogin.getAvailableBiometrics();

    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await biometricLogin.authenticate();
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;

    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await biometricLogin.authenticateWithBiometrics();
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
  }

  Future<void> _cancelAuthentication() async {
    await biometricLogin.cancelAuthentication();
    setState(() => _isAuthenticating = false);
  }

  buildCheckBiometrics() {
    return Column(
      children: [
        Text('Can check biometrics: $_canCheckBiometrics\n'),
        ElevatedButton(
          onPressed: _checkBiometrics,
          child: const Text('Check biometrics'),
        ),
        Divider(height: dividerHeight),
      ],
    );
  }

  buildAvailableBiometrics() {
    return Column(
      children: [
        Text(
          'Available biometrics: $_availableBiometrics\n',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: _getAvailableBiometrics,
          child: const Text('Get available biometrics'),
        ),
        Divider(height: dividerHeight),
      ],
    );
  }

  buildAuthenticate() {
    if (_supportState == SupportState.unknown) {
      return const CircularProgressIndicator();
    } else if (_supportState == SupportState.supported) {
      return Column(
        children: [
          const Text('Current State: \n'),
          Text(
            "$_authorized\n",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: _authorized == 'Authorized'
                    ? Colors.green
                    : _authorized == 'Authenticating'
                        ? Colors.orange
                        : Colors.red),
          ),
          if (_isAuthenticating)
            ElevatedButton(
              onPressed: _cancelAuthentication,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text('Cancel Authentication'),
                  Icon(Icons.cancel),
                ],
              ),
            )
          else
            Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _authenticate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text('Authenticate'),
                      Icon(Icons.perm_device_information),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _authenticateWithBiometrics,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_isAuthenticating
                          ? 'Cancel'
                          : 'Authenticate: biometrics only'),
                      const Icon(Icons.fingerprint),
                    ],
                  ),
                ),
              ],
            ),
        ],
      );
    }
    return const Text('This device is not supported');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: ListView(
        padding: const EdgeInsets.only(top: 30),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildCheckBiometrics(),
              buildAvailableBiometrics(),
              buildAuthenticate(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const ReturnButton(),
    );
  }
}
