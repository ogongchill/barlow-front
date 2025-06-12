import 'package:core/api/common/legislation_type.dart';
import 'package:core/api/common/params/query_parameter.dart';
import 'package:core/api/common/params/sort_key_query_parameter.dart';
import 'package:core/api/common/params/page_param.dart';
import 'package:core/api/constants/bill_proposer_param.dart';
import 'package:core/api/constants/party_param.dart';
// import 'package:features/shared/domain/bill_progress_status.dart';
// import 'package:features/shared/domain/bill_proposer_type.dart';
import 'package:core/api/common/notification_topics.dart';
import 'package:core/api/constants/progress_status_param.dart';
// import 'package:features/shared/domain/party.dart';

class NotificationFilterQueryParameter extends QueryParameter {

  NotificationFilterQueryParameter(Set<NotificationTopic> notificationTopics)
  : super({'filterTopic':  notificationTopics.map((topic) => topic.value).toList()});

  Map<String, dynamic> get params => value;
}

class BillPostQueryParameter extends QueryParameter{

  BillPostQueryParameter._(super.value);

  factory BillPostQueryParameter.from({PageQueryParam? pagingParam, SortKeyQueryParam? sortKeyParam, BillPostFilterParam? billPostFilterParam}) {
    Map<String, dynamic> params = {};
    if(pagingParam!=null) {
      params.addAll(pagingParam.value);
    }
    if(sortKeyParam!=null) {
      params.addAll(sortKeyParam.value);
    }
    if(billPostFilterParam!=null) {
      params.addAll(billPostFilterParam.value);
    }
    return BillPostQueryParameter._(params);
  }
}

class BillPostFilterParam extends QueryParameter {

  BillPostFilterParam({
    required LegislationTypeFilter? legislationType,
    required ProgressStatusFilter? progressStatus,
    required ProposerTypeFilter? proposerType,
    required PartyNameFilter? partyName
  }) : super(createMap(
      legislationType: legislationType,
      progressStatus: progressStatus,
      proposerType: proposerType,
      partyName: partyName
  ));

  static Map<String, dynamic> createMap({
    required LegislationTypeFilter? legislationType,
    required ProgressStatusFilter? progressStatus,
    required ProposerTypeFilter? proposerType,
    required PartyNameFilter? partyName}) {
    final map = <String, dynamic>{};
    if (legislationType != null && legislationType._tags.isNotEmpty) {
      map[legislationType.filterName] = legislationType._tags.toList();
    }
    if (progressStatus != null && progressStatus._tags.isNotEmpty) {
      map[progressStatus.filterName] = progressStatus._tags.toList();
    }
    if (proposerType != null && proposerType._tags.isNotEmpty) {
      map[proposerType.filterName] = proposerType._tags.toList();
    }
    if (partyName != null && partyName._tags.isNotEmpty) {
      map[partyName.filterName] = partyName._tags.toList();
    }
    return map;
  }
}

sealed class BillPostFilter {

  final String filterName;
  final Set<String> _tags;

  BillPostFilter({
    required this.filterName,
    required Set<String> tags
  }): _tags = tags;
}

class LegislationTypeFilter extends BillPostFilter {

  LegislationTypeFilter(Set<LegislationType> legislationTypes)
  : super(
    filterName: 'legislationType',
    tags: Set.of(legislationTypes.map((tag)=>tag.value))
  );
}

class ProgressStatusFilter extends BillPostFilter {

  ProgressStatusFilter(Set<ProgressStatusParam> progressStatus)
  : super(
      filterName: 'progressStatus',
      tags: Set.of(progressStatus.map((status) => status.value))
  );
}

class ProposerTypeFilter extends BillPostFilter{

  ProposerTypeFilter(Set<BillProposerParam> proposerParam)
  : super(
      filterName: 'proposerType',
      tags: Set.of(proposerParam.map((proposerParam) => proposerParam.value))
  );
}

class PartyNameFilter extends BillPostFilter {

  PartyNameFilter(Set<PartyParam> parties)
  : super(
      filterName: 'partyName',
      tags: Set.of(parties.map((party) => party.value))
  );
}