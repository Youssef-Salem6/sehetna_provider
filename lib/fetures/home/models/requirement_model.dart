class RequirementModel {
  String? id, requirementId, requirementName, requirementType;
  String? stringValue, fileUrl;

  RequirementModel({
    this.id,
    this.requirementId,
    this.requirementName,
    this.requirementType,
    this.stringValue,
    this.fileUrl,
  });

  RequirementModel.fromjson({required Map json, required String languageCode}) {
    id = json["id"].toString();
    requirementId = json["requirement_id"].toString();
    requirementName = json["name"][languageCode] ?? json["name"]["en"];
    requirementType = json["type"];
    stringValue = json["value"];
    fileUrl = json["file_url"];
  }
}
