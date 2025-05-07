import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetna_provider/core/Colors.dart';

class FeedbackCustomCard extends StatelessWidget {
  final String img, comment, clientName, rate, date;
  const FeedbackCustomCard({
    super.key,
    required this.img,
    required this.comment,
    required this.clientName,
    required this.rate,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffcde5e1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          img,
                          width: 30,
                        ),
                        const Gap(10),
                        Text(
                          rate,
                          style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Gap(5)
                      ],
                    ),
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: kSecondaryColor.withOpacity(0.6),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              clientName,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              comment,
              style: TextStyle(
                color: kSecondaryColor.withOpacity(0.7),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
