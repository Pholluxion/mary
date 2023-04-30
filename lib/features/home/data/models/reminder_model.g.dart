// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reminder _$ReminderFromJson(Map<String, dynamic> json) => Reminder(
      time: Reminder._fromJson(json['time'] as Timestamp),
      message: json['message'] as String,
      medication:
          Medication.fromJson(json['medication'] as Map<String, dynamic>),
      state: json['state'] as bool,
    );

Map<String, dynamic> _$ReminderToJson(Reminder instance) => <String, dynamic>{
      'time': Reminder._toJson(instance.time),
      'message': instance.message,
      'medication': instance.medication,
      'state': instance.state,
    };
