import 'package:json_annotation/json_annotation.dart';

part 'common_responses.g.dart';

@JsonSerializable()
class SummarySection {

  final String summaryTitle;
  final String? summaryDetail;

  SummarySection({required this.summaryTitle, required this.summaryDetail});

  factory SummarySection.fromJson(Map<String, dynamic> json) => _$SummarySectionFromJson(json);
}

@JsonSerializable()
class ProposerSection {

  final Map<String, int> proposerPartyRate;
  final List<ProposerResponse> proposerResponses;

  ProposerSection({required this.proposerResponses, required this.proposerPartyRate});

  factory ProposerSection.fromJson(Map<String, dynamic> json) => _$ProposerSectionFromJson(json);
}

@JsonSerializable()
class ProposerResponse {

  final String name;
  final String profileImage;
  final String partyName;

  ProposerResponse({
    required this.name,
    required this.profileImage,
    required this.partyName
  });

  factory ProposerResponse.fromJson(Map<String, dynamic> json) => _$ProposerResponseFromJson(json);
}

@JsonSerializable()
class BillPostThumbnail {

  final String billId;
  final String billName;
  final String proposers;
  final String legislationProcess;

  BillPostThumbnail({
    required this.billId,
    required this.billName,
    required this.proposers,
    required this.legislationProcess
  });

  factory BillPostThumbnail.fromJson(Map<String, dynamic> json) => _$BillPostThumbnailFromJson(json);
}