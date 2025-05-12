import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/chart.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/home_bloc_list.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class ProviderStatsContainer extends StatefulWidget {
  const ProviderStatsContainer({super.key});

  @override
  State<ProviderStatsContainer> createState() => _ProviderStatsContainerState();
}

class _ProviderStatsContainerState extends State<ProviderStatsContainer> {
  @override
  Widget build(BuildContext context) {
    return HomeBlocList(
      title: S.of(context).providerStats,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chart(
                  color: kSecondaryColor,
                  percent: 0.92,
                  centerTxt: "8",
                  specialize: S.of(context).requests,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chart(
                    color: kSecondaryColor,
                    percent: 0.92,
                    centerTxt: "8",
                    specialize: S.of(context).todayGain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
