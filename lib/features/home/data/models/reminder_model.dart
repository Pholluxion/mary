import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mary/features/home/data/models/medication_model.dart';

part 'reminder_model.g.dart';

@JsonSerializable()
class Reminder {
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime time;
  String message;
  Medication medication;
  bool state;

  Reminder({
    required this.time,
    required this.message,
    required this.medication,
    required this.state,
  });
  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderToJson(this);

  static DateTime _fromJson(Timestamp int) =>
      DateTime.fromMillisecondsSinceEpoch(int.millisecondsSinceEpoch);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
