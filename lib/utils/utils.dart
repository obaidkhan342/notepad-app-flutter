// ignore_for_file: dead_code

import 'package:flutter/material.dart'; // Use Flutter's TextDirection


TextDirection getTextDirection(String text) {
  final rtlChars = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');
  if (rtlChars.hasMatch(text)) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}
