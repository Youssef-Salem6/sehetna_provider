import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/core/custom_image_row.dart';
import 'package:sehetne_provider/fetures/home/manager/ongoingRequests/ongoing_requests_cubit.dart';
import 'package:sehetne_provider/fetures/home/models/ongoing_request_model.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/home_bloc_list.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/home_container_view.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/ongoing_request_card.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/provider_stats_container.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  OngoingRequestModel? ongoingRequestModel; // Keep it nullable

  @override
  void initState() {
    BlocProvider.of<OngoingRequestsCubit>(context).getOngoningRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocConsumer<OngoingRequestsCubit, OngoingRequestsState>(
      listener: (context, state) {
        if (state is OngoingRequestsSuccess) {
          try {
            // Only initialize when we have data
            if (BlocProvider.of<OngoingRequestsCubit>(
              context,
            ).ongoingRequests.isNotEmpty) {
              // Use a try-catch to handle potential JSON parsing errors
              ongoingRequestModel = OngoingRequestModel.fromJson(
                json:
                    BlocProvider.of<OngoingRequestsCubit>(
                      context,
                    ).ongoingRequests[0],
                lanCode: Localizations.localeOf(context).languageCode,
              );
            }
          } catch (e) {
            // Log the error or show a message
            debugPrint("Error parsing OngoingRequestModel: $e");
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                CustomImageRow(
                  name: pref.getString("firstName") ?? "", // Add null safety
                  image: "$imagesBaseUrl/${pref.getString("image") ?? ""}",
                ),
                Gap(size.height * 0.02),
                const HomeContainerView(),
                Gap(size.height * 0.02),
                const ProviderStatsContainer(),
                Gap(size.height * 0.02),
                HomeBlocList(
                  title: S.of(context).ongoingRequests,
                  children: [
                    if (state is OngoingRequestsSuccess &&
                        BlocProvider.of<OngoingRequestsCubit>(
                          context,
                        ).ongoingRequests.isNotEmpty &&
                        ongoingRequestModel != null) // Added null check
                      OngoingRequestCard(
                        ongoingRequestModel: ongoingRequestModel!,
                      ),
                    if (state is OngoingRequestsEmpty)
                      Center(child: Text(S.of(context).noOnngoingRequests)),
                    if (state is OngoingRequestsLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (state is OngoingRequestsFailure)
                      Center(child: Text(state.errorMessage)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
