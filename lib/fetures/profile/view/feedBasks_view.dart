import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/profile/manager/getFeedbacks/get_feedbacks_cubit.dart';
import 'package:sehetne_provider/fetures/profile/models/feedBack_model.dart';
import 'package:sehetne_provider/fetures/profile/view/widgets/feedback_custom_card.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class FeedbasksView extends StatefulWidget {
  const FeedbasksView({super.key});

  @override
  State<FeedbasksView> createState() => _FeedbasksViewState();
}

class _FeedbasksViewState extends State<FeedbasksView> {
  @override
  void initState() {
    BlocProvider.of<GetFeedbacksCubit>(context).getFeedbacks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFeedbacksCubit, GetFeedbacksState>(
      listener: (context, state) {
        if (state is GetFeedbacksFailure) {
          // Handle error if needed
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<GetFeedbacksCubit>(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: kPrimaryColor,
            title: Text(
              S.of(context).feedback,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildBody(state, cubit),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(GetFeedbacksState state, GetFeedbacksCubit cubit) {
    if (state is GetFeedbacksLoading) {
      return _buildShimmerLoading();
    } else if (state is GetFeedbacksSuccess || cubit.feedbacks.isNotEmpty) {
      return _buildFeedbackList(cubit);
    } else if (state is GetFeedbacksFailure) {
      return Center(child: Text(state.errorMessage));
    } else {
      return const Center(child: Text('No feedbacks available'));
    }
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5, // Show 5 shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 150, // Adjust height to match your FeedbackCustomCard
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeedbackList(GetFeedbacksCubit cubit) {
    return ListView.builder(
      itemCount: cubit.feedbacks.length,
      itemBuilder: (context, index) {
        FeedbackModel feedbackModel = FeedbackModel.fromJson(
          json: cubit.feedbacks[index],
        );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FeedbackCustomCard(feedbackModel: feedbackModel),
        );
      },
    );
  }
}
