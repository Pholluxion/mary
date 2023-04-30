import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class Patient {
  PatientDTO patientDTO;
  EmergencyContact emergencyContact;
  List<String> history;
  List<Medication> medications;
  List<TestResult> testResults;
  List<MedicalVisit> medicalVisits;
  List<Reminder> reminders;

  Patient({
    required this.patientDTO,
    required this.emergencyContact,
    required this.history,
    required this.medications,
    required this.testResults,
    required this.medicalVisits,
    required this.reminders,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}

@JsonSerializable()
class PatientDTO {
  final String id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String phoneNumber;
  final String emailAddress;
  final String healthInsurance;

  PatientDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.emailAddress,
    required this.healthInsurance,
  });

  factory PatientDTO.fromJson(Map<String, dynamic> json) =>
      _$PatientDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDTOToJson(this);
}
