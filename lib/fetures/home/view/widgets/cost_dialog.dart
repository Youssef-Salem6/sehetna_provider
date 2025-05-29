import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/manager/RequestDetails/request_details_cubit.dart';
import 'package:sehetne_provider/fetures/home/manager/acceptRequest/accept_request_cubit.dart';
import 'package:sehetne_provider/fetures/home/manager/ongoingRequests/ongoing_requests_cubit.dart';
import 'package:sehetne_provider/main.dart';
// ignore: must_be_immutable
class CostDialog extends StatelessWidget {
  final String requestId;
  CostDialog({super.key, required this.requestId});

  TextEditingController costController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AcceptRequestCubit(),
      child: BlocConsumer<AcceptRequestCubit, AcceptRequestState>(
        listener: (context, state) {
          if (state is AcceptRequestSuccess) {
            pref.setBool("isActive", false);
            BlocProvider.of<RequestDetailsCubit>(
              context,
            ).getRequestDetails(requestId: requestId);
            BlocProvider.of<OngoingRequestsCubit>(
              context,
            ).getOngoningRequests();
            Navigator.pop(context);
          } else if (state is AcceptRequestFailure) {
            print(state.errorMessage);
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter Cost',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.attach_money),
                      labelText: 'Amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (state is! AcceptRequestLoading) {
                            BlocProvider.of<AcceptRequestCubit>(
                              context,
                            ).acceptRequest(
                              requestId: requestId,
                              coast: costController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              state is AcceptRequestLoading
                                  ? kPrimaryColor.withOpacity(0.3)
                                  : kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          state is AcceptRequestLoading ? 'loading' : 'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
