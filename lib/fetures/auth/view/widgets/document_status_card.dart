import 'package:flutter/material.dart';
import 'package:sehetne_provider/core/custom_text.dart';

import 'package:sehetne_provider/fetures/auth/models/document_status_model.dart';
import 'package:sehetne_provider/generated/l10n.dart';

class DocumentStatusCard extends StatefulWidget {
  final DocumentStatusModel documentStatusModel;
  const DocumentStatusCard({super.key, required this.documentStatusModel});

  @override
  State<DocumentStatusCard> createState() => _DocumentStatusCardState();
}

class _DocumentStatusCardState extends State<DocumentStatusCard> {
  String getStatus(String status) {
    if (status == "pending") {
      return S.of(context).underReview;
    } else if (status == "approved") {
      return S.of(context).approved;
    } else if (status == "rejected") {
      return S.of(context).rejected;
    } else {
      return "Pending";
    }
  }

  Color getStatusColor(String status) {
    if (status == "pending") {
      return Colors.orange;
    } else if (status == "approved") {
      return Colors.green;
    } else if (status == "rejected") {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txt: widget.documentStatusModel.documentName!,
                size: 18,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(widget.documentStatusModel.status!),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CustomText(
                  txt: getStatus(widget.documentStatusModel.status!),
                  size: 16,
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.documentStatusModel.status == "rejected",
            child: Text(
              "reason : ${widget.documentStatusModel.rejectionReason}",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
