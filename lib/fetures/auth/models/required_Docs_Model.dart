class RequiredDocsModel {
  int? id;
  String? name;

  RequiredDocsModel({required this.id, required this.name});

  RequiredDocsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
