import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/manager/acceptRequest/accept_request_cubit.dart';
import 'package:sehetne_provider/fetures/home/manager/completeRequest/complete_request_cubit.dart';
import 'package:sehetne_provider/fetures/home/manager/ongoingRequests/ongoing_requests_cubit.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:sehetne_provider/main.dart';
import 'package:shimmer/shimmer.dart';

class AcceptRequestButton extends StatelessWidget {
  final String requestId, status;
  const AcceptRequestButton({
    super.key,
    required this.requestId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AcceptRequestCubit()),
        BlocProvider(create: (context) => CompleteRequestCubit()),
      ],
      child: BlocConsumer<AcceptRequestCubit, AcceptRequestState>(
        listener: (context, state) {
          if (state is AcceptRequestSuccess) {
            BlocProvider.of<OngoingRequestsCubit>(
              context,
            ).getOngoningRequests();
            pref.setBool("isActive", false);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AcceptRequestFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<CompleteRequestCubit, CompleteRequestState>(
            listener: (context, completeState) {
              if (completeState is CompleteRequestSuccess) {
                BlocProvider.of<OngoingRequestsCubit>(
                  context,
                ).getOngoningRequests();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(completeState.message),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (completeState is CompleteRequestFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(completeState.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, completeState) {
              // Show shimmer if either state is loading
              if (state is AcceptRequestLoading ||
                  completeState is CompleteRequestLoading) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (status == "pending") {
                          BlocProvider.of<AcceptRequestCubit>(
                            context,
                          ).acceptRequest(requestId: requestId);
                        } else if (status == "accepted") {
                          BlocProvider.of<CompleteRequestCubit>(
                            context,
                          ).completeRequest(requestId: requestId);
                        }
                      },
                      child: Text(
                        status == "pending"
                            ? S.of(context).accept
                            : S.of(context).complete,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
