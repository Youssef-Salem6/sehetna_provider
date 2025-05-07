import 'package:flutter/material.dart';
import 'package:sehetna_provider/core/Colors.dart';
import 'package:sehetna_provider/fetures/profile/view/widgets/feedback_custom_card.dart';
import 'package:sehetna_provider/generated/l10n.dart';

class FeedbasksView extends StatefulWidget {
  const FeedbasksView({super.key});

  @override
  State<FeedbasksView> createState() => _FeedbasksViewState();
}

class _FeedbasksViewState extends State<FeedbasksView> {
  @override
  Widget build(BuildContext context) {
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
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: FeedbackCustomCard(
                  img: "assets/images/Icons/solar_stars-bold.svg",
                  comment:
                      "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit.",
                  clientName: "Ahmed Sabry",
                  rate: "4",
                  date: "Apr 14, 2025 - 06:40 PM",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
