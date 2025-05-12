class ComplaintModel {
  String? id, subject, description, status, createdAt, response;

  ComplaintModel({
    required this.createdAt,
    required this.description,
    required this.id,
    required this.status,
    required this.subject,
    required this.response,
  });

  ComplaintModel.fromjson({required Map json}) {
    id = json["id"].toString();
    status = json["status"];
    response = json["response"];
    subject = json["subject"];
    description = json["description"];
    createdAt = json["created_at"] ?? "2025-04-30T14:03:08.000000Z";
  }
}
