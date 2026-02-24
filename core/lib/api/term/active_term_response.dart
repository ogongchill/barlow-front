import 'package:json_annotation/json_annotation.dart';

part 'active_term_response.g.dart';

@JsonSerializable()
class ActiveTermResponse {

  final List<ActiveTerm> activeTerms;

  ActiveTermResponse({required this.activeTerms});

  factory ActiveTermResponse.fromJson(Map<String, dynamic> json) => _$ActiveTermResponseFromJson(json);
}

@JsonSerializable()
class ActiveTerm {

  final int id;
  final String title;
  final String linkUrl;
  final String type;
  final String version;
  final bool required;
  final DateTime effectiveAt;

  ActiveTerm({
    required this.id,
    required this.title,
    required this.linkUrl,
    required this.type,
    required this.version,
    required this.required,
    required this.effectiveAt
  });

  factory ActiveTerm.fromJson(Map<String, dynamic> json) => _$ActiveTermFromJson(json);
}
