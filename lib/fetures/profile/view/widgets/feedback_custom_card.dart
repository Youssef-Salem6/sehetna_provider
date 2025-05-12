import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/profile/models/feedBack_model.dart';


class FeedbackCustomCard extends StatelessWidget {
  final FeedbackModel feedbackModel;
  const FeedbackCustomCard({
    super.key,
    required this.feedbackModel,
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
                          "assets/images/Icons/solar_stars-bold.svg",
                          width: 30,
                        ),
                        const Gap(10),
                        Text(
                          feedbackModel.rating!,
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
                  DateFormat("MMM dd, yyyy - hh:mm a")
                      .format(DateTime.parse(feedbackModel.createdAt!)),
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
              feedbackModel.customerName!,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              feedbackModel.comment!,
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
