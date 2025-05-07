import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sehetna_provider/core/Colors.dart';
import 'package:sehetna_provider/generated/l10n.dart';

class CustomRequestCard extends StatelessWidget {
  const CustomRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Provider Name",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    "Category",
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    "March 5, 10:00 AM",
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(size.width * 0.25),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).showDetails,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Image(
                image: AssetImage("assets/images/users/man (1).png"),
                width: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
