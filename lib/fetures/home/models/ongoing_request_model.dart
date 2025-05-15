class OngoingRequestModel {
  String? id, serviceName, createdAt, customerName, customerImage;

  OngoingRequestModel({
    required this.id,
    required this.customerName,
    required this.createdAt,
    required this.serviceName,
  });

  OngoingRequestModel.fromJson({required Map json, required String lanCode}) {
    id = json["id"].toString();
    // Fix typo: "customrt" should be "customer"
    customerName = json["customer"]["name"];
    customerImage = json["customer"]["image"];
    createdAt = json["created_at"];
    // Check if services array exists and has elements
    if (json["services"] != null &&
        json["services"] is List &&
        (json["services"] as List).isNotEmpty &&
        json["services"][0]["name"] != null) {
      serviceName = json["services"][0]["name"][lanCode];
    } else {
      serviceName = "Unknown Service";
    }
  }
}
