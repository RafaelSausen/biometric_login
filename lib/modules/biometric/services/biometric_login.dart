import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricLogin {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;

  BiometricLogin() {
    initialize();
  }

  initialize() async {
    bool isSupported = await auth.isDeviceSupported();
    supportState =
        isSupported ? SupportState.supported : SupportState.unsupported;
  }

  Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      return availableBiometrics;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      availableBiometrics = <BiometricType>[];
      rethrow;
    }
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      throw 'Error - ${e.message}';
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
