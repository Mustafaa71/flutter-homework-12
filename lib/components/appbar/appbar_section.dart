import 'package:flutter/material.dart';
import 'package:flutter_homework_12/constants.dart';
import 'package:intl/intl.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String getCurrentDateForAppbar() {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('d MMMM, EEEE', 'en_US');
      return formatter.format(now);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'City Name',
              style: Constants.kMediumTextStyle,
            ),
            const Spacer(),
            const Icon(Icons.search, size: 35.0, color: Colors.white),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          getCurrentDateForAppbar(),
          style: Constants.kSmallTextStyle,
        ),
      ],
    );
  }
}
