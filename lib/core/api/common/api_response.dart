import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

enum ResultType {

  @JsonValue("SUCCESS")
  success,

  @JsonValue("ERROR")
  error
}

@JsonSerializable()
class ErrorMessage {

  final String code;
  final String message;
  Object? data;

  ErrorMessage({
    required this.code,
    required this.message,
    this.data
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageFromJson(json);
}

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {

  final ResultType result;
  T? data;
  ErrorMessage? error;

  ApiResponse({
    required this.result,
    this.data,
    this.error
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}