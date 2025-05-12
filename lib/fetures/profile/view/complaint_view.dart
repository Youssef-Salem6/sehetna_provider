import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/profile/manager/getComplaints/get_complaints_cubit.dart';
import 'package:sehetne_provider/fetures/profile/models/complaints_model.dart';
import 'package:sehetne_provider/fetures/profile/view/widgets/complaint_custom_card.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';


class ComplaintView extends StatefulWidget {
  const ComplaintView({super.key});

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
  @override
  void initState() {
    BlocProvider.of<GetComplaintsCubit>(context).getComplaints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetComplaintsCubit, GetComplaintsState>(
      listener: (context, state) {
        if (state is GetComplaintsFailure) {}
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<GetComplaintsCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).complaints,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: kPrimaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: _buildBody(state, cubit),
        );
      },
    );
  }

  Widget _buildBody(GetComplaintsState state, GetComplaintsCubit cubit) {
    if (state is GetComplaintsLoading) {
      return _buildShimmerList();
    } else if (state is GetComplaintsSuccess || cubit.complaints.isNotEmpty) {
      return ListView.builder(
        itemCount: cubit.complaints.length,
        itemBuilder: (context, index) {
          return ComplaintCustomCard(
            complaintModel:
                ComplaintModel.fromjson(json: cubit.complaints[index]),
          );
        },
      );
    } else if (state is GetComplaintsFailure) {
      return Center(child: Text(state.errorMessage));
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
          child: _ShimmerComplaintCard(),
        );
      },
    );
  }
}

class _ShimmerComplaintCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with date and status
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 150,
                  height: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // Subject
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              width: double.infinity,
              height: 20,
              color: Colors.white,
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                Container(
                  width: 200,
                  height: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // Response section
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: Container(
                    width: 100,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 250,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
