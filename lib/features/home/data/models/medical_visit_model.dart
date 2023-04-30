import 'package:json_annotation/json_annotation.dart';

part 'medical_visit_model.g.dart';

@JsonSerializable()
class MedicalVisit {
  String date;
  String diagnosis;
  String treatment;
  String physician;

  MedicalVisit({
    required this.date,
    required this.diagnosis,
    required this.treatment,
    required this.physician,
  });

  factory MedicalVisit.fromJson(Map<String, dynamic> json) =>
      _$MedicalVisitFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalVisitToJson(this);
}
