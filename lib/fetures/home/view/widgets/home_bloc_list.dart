import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:sehetne_provider/constants/details.dart';
import 'package:sehetne_provider/fetures/profile/view/profile_view.dart';

class HomeBlocList extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const HomeBlocList({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffefefef),
            boxShadow: Details.boxShadowList,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTxt(txt: title, size: 16),
                Gap(screenSize.height * 0.01),
                Column(children: children),
                const Gap(8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
