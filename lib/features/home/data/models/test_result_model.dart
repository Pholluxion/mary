import 'package:json_annotation/json_annotation.dart';

part 'test_result_model.g.dart';

@JsonSerializable()
class TestResult {
  String type;
  String result;

  TestResult({
    required this.type,
    required this.result,
  });

  factory TestResult.fromJson(Map<String, dynamic> json) =>
      _$TestResultFromJson(json);

  Map<String, dynamic> toJson() => _$TestResultToJson(this);
}
