import 'package:flutter/material.dart';
import 'package:flutter_homework_12/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralStatus extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const GeneralStatus({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: GoogleFonts.chakraPetch(
              fontSize: Constants.kSmallFontSize,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            title,
            style: GoogleFonts.chakraPetch(
              fontSize: Constants.kSmallFontSize,
              color: const Color(0xFF7e7f84),
            ),
          ),
        ],
      ),
    );
  }
}
