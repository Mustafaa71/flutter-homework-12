import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  /// This Section Contain All Text Style For App ...

  static const kSmallFontSize = 20.0;
  static const kMeduimFontSize = 30.0;
  static const kLargeFontSize = 75.0;

  static final kSmallTextStyle = GoogleFonts.chakraPetch(
    fontSize: Constants.kSmallFontSize,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF656768),
  );

  static final kMediumTextStyle = GoogleFonts.russoOne(
    fontSize: Constants.kMeduimFontSize,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final kLargeTextStyle = GoogleFonts.russoOne(
    fontSize: Constants.kLargeFontSize,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final kForecastDayTextStyle = GoogleFonts.chakraPetch(
    fontSize: Constants.kSmallFontSize,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final kForecastHighestTextStyle = GoogleFonts.chakraPetch(
    fontSize: Constants.kSmallFontSize,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
