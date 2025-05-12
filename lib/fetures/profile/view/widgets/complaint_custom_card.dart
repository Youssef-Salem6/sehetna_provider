import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sehetne_provider/core/Colors.dart';
import 'package:sehetne_provider/fetures/profile/models/complaints_model.dart';
import 'package:sehetne_provider/generated/l10n.dart';


class ComplaintCustomCard extends StatelessWidget {
  final ComplaintModel complaintModel;
  const ComplaintCustomCard({super.key, required this.complaintModel});

  @override
  Widget build(BuildContext context) {
    final isResolved = complaintModel.status?.toLowerCase() == 'resolved';
    final isPending = complaintModel.status?.toLowerCase() == 'pending';
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(complaintModel.status)
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isResolved
                            ? Icons.check_circle
                            : isPending
                                ? Icons.access_time
                                : Icons.info,
                        size: 16,
                        color: _getStatusColor(complaintModel.status),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getLocalizedStatus(complaintModel.status, context),
                        style: TextStyle(
                          color: _getStatusColor(complaintModel.status),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat("MMM dd, yyyy - hh:mm a")
                      .format(DateTime.parse(complaintModel.createdAt!)),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Subject
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              complaintModel.subject ?? S.of(context).noSubjectText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              complaintModel.description ?? S.of(context).noDescriptionText,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
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
                  child: Row(
                    children: [
                      const Icon(
                        Icons.message,
                        size: 18,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).responseTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Text(
                    complaintModel.response?.isNotEmpty == true
                        ? complaintModel.response!
                        : S.of(context).noResponseText,
                    style: TextStyle(
                      color: complaintModel.response?.isNotEmpty == true
                          ? Colors.grey[700]
                          : Colors.grey[500],
                      fontSize: 14,
                      fontStyle: complaintModel.response?.isNotEmpty == true
                          ? FontStyle.normal
                          : FontStyle.italic,
                    ),
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

Color _getStatusColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'resolved':
      return Colors.green;
    case 'closed':
      return Colors.red;
    case 'open':
      return Colors.orange;
    case "in progress":
      return Colors.blueAccent;
    default:
      return const Color(0xFF3599C5);
  }
}

String _getLocalizedStatus(String? status, BuildContext context) {
  switch (status?.toLowerCase()) {
    case 'resolved':
      return S.of(context).statusResolved;
    case 'closed':
      return S.of(context).statusClosed;
    case 'open':
      return S.of(context).statusOpen;
    case "in progress":
      return S.of(context).statusInProgress;
    default:
      return S.of(context).statusPending;
  }
}
