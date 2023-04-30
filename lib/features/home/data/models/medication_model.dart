import 'package:json_annotation/json_annotation.dart';

part 'medication_model.g.dart';

@JsonSerializable()
class Medication {
  String name;
  String dosage;
  String frequency;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
  });

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}
