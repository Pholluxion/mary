// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalVisit _$MedicalVisitFromJson(Map<String, dynamic> json) => MedicalVisit(
      date: json['date'] as String,
      diagnosis: json['diagnosis'] as String,
      treatment: json['treatment'] as String,
      physician: json['physician'] as String,
    );

Map<String, dynamic> _$MedicalVisitToJson(MedicalVisit instance) =>
    <String, dynamic>{
      'date': instance.date,
      'diagnosis': instance.diagnosis,
      'treatment': instance.treatment,
      'physician': instance.physician,
    };
