import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/view/widgets/custom_request_card.dart';
import 'package:sehetne_provider/fetures/profile/manager/getRequests/get_requests_cubit.dart';
import 'package:sehetne_provider/fetures/profile/models/requests_model.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';


class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    BlocProvider.of<GetRequestsCubit>(context).getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<GetRequestsCubit, GetRequestsState>(
      listener: (context, state) {
        if (state is GetRequestsFailure) {}
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<GetRequestsCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).history,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: kPrimaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: size.height * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffefefef),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildContent(state, cubit, context),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(
      GetRequestsState state, GetRequestsCubit cubit, BuildContext context) {
    if (state is GetRequestsLoading) {
      return _buildShimmerList();
    } else if (state is GetRequestsSuccess || cubit.requests.isNotEmpty) {
      return ListView.builder(
        itemCount: cubit.requests.length,
        itemBuilder: (context, index) {
          return CustomRequestCard(
              requestsModel: RequestsModel.fromJson(
            json: cubit.requests[index],
            languageCode: Localizations.localeOf(context).languageCode,
          ));
        },
      );
    } else if (state is GetRequestsFailure) {
      return Center(child: Text(state.error));
    } else {
      return _buildShimmerList();
    }
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5, // Number of shimmer items to show
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const _ShimmerRequestCard(),
        );
      },
    );
  }
}

class _ShimmerRequestCard extends StatelessWidget {
  const _ShimmerRequestCard();

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
                  Container(
                    width: size.width * 0.4,
                    height: 16,
                    color: Colors.white,
                  ),
                  const Gap(2),
                  Container(
                    width: size.width * 0.3,
                    height: 14,
                    color: Colors.white,
                  ),
                  const Gap(2),
                  Container(
                    width: size.width * 0.35,
                    height: 14,
                    color: Colors.white,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(size.width * 0.25),
                      Container(
                        width: size.width * 0.2,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
