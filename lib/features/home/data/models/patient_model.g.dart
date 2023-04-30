// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      patientDTO:
          PatientDTO.fromJson(json['patientDTO'] as Map<String, dynamic>),
      emergencyContact: EmergencyContact.fromJson(
          json['emergencyContact'] as Map<String, dynamic>),
      history:
          (json['history'] as List<dynamic>).map((e) => e as String).toList(),
      medications: (json['medications'] as List<dynamic>)
          .map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
      testResults: (json['testResults'] as List<dynamic>)
          .map((e) => TestResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      medicalVisits: (json['medicalVisits'] as List<dynamic>)
          .map((e) => MedicalVisit.fromJson(e as Map<String, dynamic>))
          .toList(),
      reminders: (json['reminders'] as List<dynamic>)
          .map((e) => Reminder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'patientDTO': instance.patientDTO,
      'emergencyContact': instance.emergencyContact,
      'history': instance.history,
      'medications': instance.medications,
      'testResults': instance.testResults,
      'medicalVisits': instance.medicalVisits,
      'reminders': instance.reminders,
    };

PatientDTO _$PatientDTOFromJson(Map<String, dynamic> json) => PatientDTO(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      emailAddress: json['emailAddress'] as String,
      healthInsurance: json['healthInsurance'] as String,
    );

Map<String, dynamic> _$PatientDTOToJson(PatientDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'emailAddress': instance.emailAddress,
      'healthInsurance': instance.healthInsurance,
    };
