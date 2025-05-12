import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sehetne_provider/core/Colors.dart';

class Chart extends StatelessWidget {
  final Color color;
  final double percent;
  final String centerTxt, specialize;
  const Chart({
    super.key,
    required this.color,
    required this.percent,
    required this.centerTxt,
    required this.specialize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50, // Size of the circle
          lineWidth: 12, // Thickness of the progress bar
          percent: percent, // 70% progress
          center: Text(
            centerTxt,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
            ),
          ),
          progressColor: color, // Color of the progress bar
          backgroundColor: const Color(
            0xffd9d9d9,
          ), // Background color of the circle
          circularStrokeCap: CircularStrokeCap.round, // Rounded edges
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '• ', // Bullet point
              style: TextStyle(
                color: color, // Same color as the progress bar
                fontSize: 24,
                fontWeight: FontWeight.w900, // Adjust size as needed
              ),
            ),
            Text(
              specialize,
              style: const TextStyle(color: kSecondaryColor, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
