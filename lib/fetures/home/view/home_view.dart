import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sehetna_provider/constants/apis.dart';
import 'package:sehetna_provider/core/custom_image_row.dart';
import 'package:sehetna_provider/fetures/home/view/widgets/home_bloc_list.dart';
import 'package:sehetna_provider/fetures/home/view/widgets/home_container_view.dart';
import 'package:sehetna_provider/fetures/home/view/widgets/provider_stats_container.dart';
import 'package:sehetna_provider/generated/l10n.dart';
import 'package:sehetna_provider/main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomImageRow(
                name: pref.getString("firstName")!,
                image: "$imagesBaseUrl/${pref.getString("image")!}"),
            Gap(size.height * 0.02),
            const HomeContainerView(),
            Gap(size.height * 0.02),
            const ProviderStatsContainer(),
            Gap(size.height * 0.02),
            HomeBlocList(title: S.of(context).ongoingRequests, children: const [
              // CustomRequestCard(),
            ]),
          ],
        ),
      ),
    );
  }
}
