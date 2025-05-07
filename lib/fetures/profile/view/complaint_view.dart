import 'package:flutter/material.dart';
import 'package:sehetna_provider/fetures/profile/models/complaints_model.dart';
import 'package:sehetna_provider/fetures/profile/view/widgets/complaint_custom_card.dart';

class ComplaintView extends StatefulWidget {
  const ComplaintView({super.key});

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ComplaintCustomCard(
            complaintModel: ComplaintModel(
              createdAt: "2025-04-30T14:03:08.000000Z",
              description: "Comment",
              id: "5",
              status: "closed",
              subject: "nothing",
              response: "",
            ),
          ),
        ],
      ),
    );
  }
}
