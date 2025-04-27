import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/core/api/common/notification_topics.dart';
import 'package:front/features/shared/domain/bill_progress_status.dart';
import 'package:front/features/shared/domain/bill_proposer_type.dart';
import 'package:front/features/shared/domain/party.dart';

class NotificationFilterParam {

  final Map<String, dynamic> _params;

  NotificationFilterParam(Set<NotificationTopic> notificationTopics)
  : _params = {
    'filterTopic':  notificationTopics.map((topic) => topic.value).toList()
  };

  Map<String, dynamic> get params => _params;
}


class BillPostParams {

  final Map<String, dynamic> _params;

  BillPostParams._(this._params);

  factory BillPostParams.from({PagingParam? pagingParam, SortKeyParam? sortKeyParam, BillPostFilterParam? billPostFilterParam}) {
    Map<String, dynamic> params = {};
    if(pagingParam!=null) {
      params.addAll(pagingParam._pagingParam);
    }
    if(sortKeyParam!=null) {
      params.addAll(sortKeyParam._sortKeyParam);
    }
    if(billPostFilterParam!=null) {
      params.addAll(billPostFilterParam.toMap());
    }
    return BillPostParams._(params);
  }

  Map<String, dynamic> get params => _params;
}

class PagingParam {

  final Map<String, dynamic> _pagingParam;

  PagingParam(int page, int size) : _pagingParam = {
    'page': page,
    'size': size
  };
}

enum SortKey {

  createdAtDesc("SORT_CREATED_AT_DESC"),
  createdAtAsc("SORT_CREATED_AT_ASC"),
  ;

  final String value;

  const SortKey(this.value);
}

class SortKeyParam {

  final Map<String, dynamic> _sortKeyParam;

  SortKeyParam(SortKey sortKey)
  : _sortKeyParam = {
    'sort': sortKey.value
  };
}


class BillPostFilterParam {

  final LegislationFilterTag? legislationType;
  final ProgressStatusFilter? progressStatus;
  final ProposerTypeFilter? proposerType;
  final PartyNameFilter? partyName;


  BillPostFilterParam({
    this.legislationType,
    this.progressStatus,
    this.proposerType,
    this.partyName
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (legislationType != null && legislationType!._tags.isNotEmpty) {
      map[legislationType!.filterName] = legislationType!._tags.toList();
    }
    if (progressStatus != null && progressStatus!._tags.isNotEmpty) {
      map[progressStatus!.filterName] = progressStatus!._tags.toList();
    }
    if (proposerType != null && proposerType!._tags.isNotEmpty) {
      map[proposerType!.filterName] = proposerType!._tags.toList();
    }
    if (partyName != null && partyName!._tags.isNotEmpty) {
      map[partyName!.filterName] = partyName!._tags.toList();
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

class LegislationFilterTag extends BillPostFilter {

  LegislationFilterTag(Set<LegislationType> legislationTypes)
  : super(
    filterName: 'legislationType',
    tags: Set.of(legislationTypes.map((tag)=>tag.value))
  );
}

class ProgressStatusFilter extends BillPostFilter {

  ProgressStatusFilter(Set<ProgressStatus> progressStatus)
  : super(
      filterName: 'progressStatus',
      tags: Set.of(progressStatus.map((status) => status.upperCaseWithUnderscore))
  );
}

class ProposerTypeFilter extends BillPostFilter{

  ProposerTypeFilter(Set<BillProposerType> proposerType)
  : super(
      filterName: 'proposerType',
      tags: Set.of(proposerType.map((proposerType) => proposerType.upperCaseWithUnderscore))
  );
}

class PartyNameFilter extends BillPostFilter {

  PartyNameFilter(Set<Party> parties)
  : super(
      filterName: 'partyName',
      tags: Set.of(parties.map((party) => party.uppercaseWithUnderscore))
  );
}