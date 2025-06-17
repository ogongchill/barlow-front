import 'package:json_annotation/json_annotation.dart';

part 'version_check_response.g.dart';

@JsonSerializable()
class VersionCheckResponseBody {
  final bool needForceUpdate;
  final bool isUpdateAvailable;

  VersionCheckResponseBody({
    required this.needForceUpdate,
    required this.isUpdateAvailable
  });

  factory VersionCheckResponseBody.fromJson(Map<String, dynamic> json) => _$VersionCheckResponseBodyFromJson(json);
}