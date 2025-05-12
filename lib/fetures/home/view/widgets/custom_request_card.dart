import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/home/view/request_Details_view.dart';
import 'package:sehetne_provider/fetures/profile/models/requests_model.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class CustomRequestCard extends StatelessWidget {
  final RequestsModel requestsModel;

  const CustomRequestCard({super.key, required this.requestsModel});

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
                    requestsModel.customerName!,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    requestsModel.categoryName!,
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    DateFormat(
                      "MMM dd, yyyy - hh:mm a",
                    ).format(DateTime.parse(requestsModel.createdAt!)),
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
                                requestId: requestsModel.id!,
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
              const Image(
                image: AssetImage("assets/images/users/man (1).png"),
                width: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
