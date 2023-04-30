import 'package:json_annotation/json_annotation.dart';

part 'emergency_contact_model.g.dart';

@JsonSerializable()
class EmergencyContact {
  String name;
  String relationship;
  String phoneNumber;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);
}
