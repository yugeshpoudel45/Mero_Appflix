// To parse this JSON data, do
//
//     final guestSessionModel = guestSessionModelFromJson(jsonString);

import 'dart:convert';

GuestSessionModel guestSessionModelFromJson(String str) =>
    GuestSessionModel.fromJson(json.decode(str));

String guestSessionModelToJson(GuestSessionModel data) =>
    json.encode(data.toJson());

class GuestSessionModel {
  bool? success;
  String? guestSessionId;
  String? expiresAt;

  GuestSessionModel({
    this.success,
    this.guestSessionId,
    this.expiresAt,
  });

  factory GuestSessionModel.fromJson(Map<String, dynamic> json) =>
      GuestSessionModel(
        success: json["success"] ?? false,
        guestSessionId: json["guest_session_id"] ?? "unavailable",
        expiresAt: json["expires_at"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "guest_session_id": guestSessionId,
        "expires_at": expiresAt,
      };
}
