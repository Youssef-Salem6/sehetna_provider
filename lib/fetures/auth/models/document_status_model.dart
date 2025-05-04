class DocumentStatusModel {
  final String? status;
  final String? documentName, rejectionReason;

  DocumentStatusModel({
    required this.rejectionReason,
    required this.status,
    required this.documentName,
  });

  factory DocumentStatusModel.fromJson(Map<String, dynamic> json) {
    return DocumentStatusModel(
      status: json['status'],
      documentName: json['document_name'],
      rejectionReason: json['rejection_reason'],
    );
  }
}
