import 'dart:convert';

DeleteSessionModel deleteSessionModelFromJson(String str) =>
    DeleteSessionModel.fromJson(json.decode(str));

String deleteSessionModelToJson(DeleteSessionModel data) =>
    json.encode(data.toJson());

class DeleteSessionModel {
  bool? success;

  DeleteSessionModel({
    this.success,
  });

  factory DeleteSessionModel.fromJson(Map<String, dynamic> json) =>
      DeleteSessionModel(
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
