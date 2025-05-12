import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/constants/details.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class HomeContainerView extends StatelessWidget {
  const HomeContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: Details.boxShadowList,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        gradient: const LinearGradient(
          colors: [kPrimaryColor, kSecondaryColor],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).welcomeToSehetnaApp,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(size.height * 0.01),
                  Text(
                    S.of(context).readyToReceiveRequests,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(size.height * 0.006),
                  Text(
                    S.of(context).homeContainerDescription,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              "assets/images/Push notifications-pana 1.svg",
              width: 96,
            ),
          ],
        ),
      ),
    );
  }
}
