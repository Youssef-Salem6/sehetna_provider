class RequestsModel {
  String? id, customerId, serviceId, phone, address, status, serviceName;
  String? price;
  String? createdAt, categoryName;
  bool? hasfeedBack, hasCancellation;
  List? feedbacks, complaints, services;
  int? isMultiaple, categoryId;
  String? customerName,
      customerPhone,
      customerImage,
      customerGender,
      customerAge;

  RequestsModel(
      {required this.address,
      required this.customerId,
      required this.id,
      required this.phone,
      required this.price,
      required this.serviceId,
      required this.serviceName,
      required this.status,
      required this.hasfeedBack,
      required this.hasCancellation,
      required this.complaints,
      required this.feedbacks,
      required this.createdAt,
      required this.services,
      required this.isMultiaple,
      required this.categoryId,
      required this.categoryName,
      required this.customerAge,
      required this.customerGender,
      required this.customerImage,
      required this.customerName,
      required this.customerPhone});

  RequestsModel.fromJson({required Map json, required String languageCode}) {
    Map customer = json["customer"];
    id = json["id"].toString();
    customerId = json["customer_id"].toString();
    serviceId = json["service_id"].toString();
    phone = json["phone"];
    address = json["address"];
    status = json["status"];
    feedbacks = json["feedbacks"];
    complaints = json["complaints"];
    hasfeedBack = json["has_feedback"];
    hasCancellation = json["has_cancellations"];
    serviceName = json["services"][0]["name"][languageCode];
    services = json["services"];
    price = json["total_price"];
    createdAt = json["created_at"] ?? "2025-05-07T19:37";
    isMultiaple = json["services"][0]["category"]["is_multiple"];
    categoryId = json["services"][0]["category"]["id"];
    categoryName = json["services"][0]["category"]["name"][languageCode];
    customerName = customer["name"];
    customerAge = customer["age"].toString();
    customerGender = customer["gender"];
    customerImage = customer["image"];
    customerPhone = customer["phone"];
  }
}
