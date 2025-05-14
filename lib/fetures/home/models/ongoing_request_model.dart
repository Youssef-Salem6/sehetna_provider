class OngoingRequestModel {
  String? id, serviceName, createdAt, customerName;

  OngoingRequestModel({
    required this.id,
    required this.customerName,
    required this.createdAt,
    required this.serviceName,
  });

  OngoingRequestModel.fromJson({required Map json, required String lanCode}) {
    id = json["id"].toString();
    customerName = json["customrt"]["name"];
    createdAt = json["created_at"];
    serviceName = json["services"][0]["name"][lanCode];
  }
}
