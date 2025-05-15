import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/models/ongoing_request_model.dart';
import 'package:sehetne_provider/fetures/home/view/request_Details_view.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class OngoingRequestCard extends StatelessWidget {
  final OngoingRequestModel ongoingRequestModel;
  const OngoingRequestCard({super.key, required this.ongoingRequestModel});

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
                  Text(
                    ongoingRequestModel.customerName!,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Gap(2),
                  // Text(
                  //   ongoingRequestModel.categoryName!,
                  //   style: TextStyle(
                  //     color: kPrimaryColor.withOpacity(0.4),
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const Gap(2),
                  Text(
                    DateFormat(
                      "MMM dd, yyyy - hh:mm a",
                    ).format(DateTime.parse(ongoingRequestModel.createdAt!)),
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => RequestDetailsView(
                                requestId: ongoingRequestModel.id!,
                              ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(size.width * 0.25),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).showDetails,
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage(
                    "$imagesBaseUrl/${ongoingRequestModel.customerImage}",
                  ),
                  width: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
