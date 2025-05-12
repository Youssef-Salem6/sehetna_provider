class FeedbackModel {
  String? id, rating, comment, createdAt, customerName;

  FeedbackModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.customerName,
  });

  FeedbackModel.fromJson({required Map json}) {
    id = json["id"].toString();
    rating = json["rating"].toString();
    comment = json["comment"];
    createdAt = json["created_at"];
    customerName = json["customer"]["name"];
  }
}
