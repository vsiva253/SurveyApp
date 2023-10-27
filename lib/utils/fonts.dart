import 'dart:ui';

import 'package:flutter/material.dart';

class MainFonts {
  static TextStyle uploadButtonText() {
    return TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, color:  Colors.black);
  }

  static TextStyle lableText({Color color =  Colors.black}) {
    return TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle suggestionText({Color color =  Colors.black}) {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle pageTitleText({Color color =  Colors.black}) {
    return TextStyle(
        fontSize: 24, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle pageBigTitleText() {
    return TextStyle(
        fontSize: 36, fontWeight: FontWeight.w600, color:  Colors.black);
  }

  static TextStyle filterText({Color color =  Colors.black}) {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle hintFieldText({Color color =  Colors.grey, double fontSize = 18}) {
    return TextStyle(fontSize: fontSize, color: color);
  }

  static TextStyle textFieldText() {
    return TextStyle(fontSize: 19, color:  Colors.black);
  }

  static TextStyle settingLabel() {
    return TextStyle(fontSize: 18, color:  Colors.black);
  }

    static TextStyle dashText({Color color =  Colors.black}) {
    return TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: color, decoration: TextDecoration.underline,);
  }
    static TextStyle dashNoText({Color color =  Colors.white}) {
    return TextStyle(
        fontSize: 26, fontWeight: FontWeight.w500, color: color,);
  }
}

// In use
class AuthFonts {
  static authMsgText({Color color =  Colors.grey}) {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle authButtonText({Color color =  Colors.black}) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: color);
  }
}
