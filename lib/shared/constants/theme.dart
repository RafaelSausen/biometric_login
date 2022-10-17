import 'package:flutter/material.dart';

// App Title
const String appTitle = 'Biometric Login Flutter Demo';

// AppBar
AppBar appbar = AppBar(
  title: const Text(appTitle),
);

// Theme
const kPrimaryColor = Colors.purple;

// Main Button
const kButtonColor = Colors.purple;
const kButtonText = Colors.white;

// Icons
const kIconColor = Colors.purple;

// Text
const kHintTextStyle = TextStyle(
  color: Colors.purple,
  fontFamily: 'OpenSans',
);

const kLabelTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.purple,
);

// Decoration
final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFFFFFFFF),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
