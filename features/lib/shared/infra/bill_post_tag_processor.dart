import 'package:core/api/common/params/api_request_params.dart';
import 'package:core/api/common/params/page_param.dart';
import 'package:core/api/pre-announce/pre_announce_request_param.dart';
import 'package:features/pre_announce/domain/repositories/sort_key.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:core/api/common/legislation_type.dart';
import 'package:features/shared/domain/page.dart';

class BillPostTagParamProcessor {

  static PreAnnounceParam composePreAnnounceParamFrom(Page page, List<BillPostTag> tags, PreAnnounceBillPostSortKey sortKey) {
    final grouped = groupByType(tags);
    return PreAnnounceParam.from(
        pagingParam: PageQueryParam(page.index, page.size),
        preAnnounceSortKey: sortKey.isAscending ? PreAnnounceSortKey.deadlineAsc : PreAnnounceSortKey.deadlineDesc,
        billPostFilterParam: BillPostFilterParam(
        legislationType: LegislationTypeFilter(
          getGroupedListByType<CommitteeTag>(grouped, CommitteeTag)
              .map((committeeTag) => CommitteeLegislationType.of(committeeTag.value.param))
              .toSet()
          ),
        progressStatus: ProgressStatusFilter(
          getGroupedListByType<ProgressStatusTag>(grouped, ProgressStatusTag)
              .map((progressStatusTag) => progressStatusTag.value.param)
              .toSet()
          ),
        proposerType: ProposerTypeFilter(
          getGroupedListByType<BillProposerTypeTag>(grouped, BillProposerTypeTag)
              .map((proposerTag) => proposerTag.value.param)
              .toSet()
          ),
        partyName: PartyNameFilter(
          getGroupedListByType<PartyTag>(grouped, PartyTag)
              .map((partyTag) => partyTag.value.param)
              .toSet()
          ),
      )
    );
  }

  static BillPostQueryParameter composeFrom(Page page, List<BillPostTag> tags) {
    final grouped = groupByType(tags);
    return BillPostQueryParameter.from(
        pagingParam: PageQueryParam(page.index, page.size),
        billPostFilterParam: BillPostFilterParam(
            legislationType: LegislationTypeFilter(
                getGroupedListByType<CommitteeTag>(grouped, CommitteeTag)
                    .map((committeeTag) => CommitteeLegislationType.of(committeeTag.value.param))
                    .toSet()
            ),
            progressStatus: ProgressStatusFilter(
                getGroupedListByType<ProgressStatusTag>(grouped, ProgressStatusTag)
                    .map((progressStatusTag) => progressStatusTag.value.param)
                    .toSet()
            ),
            proposerType: ProposerTypeFilter(
                getGroupedListByType<BillProposerTypeTag>(grouped, BillProposerTypeTag)
                    .map((proposerTag) => proposerTag.value.param)
                    .toSet()
            ),
            partyName: PartyNameFilter(
                getGroupedListByType<PartyTag>(grouped, PartyTag)
                    .map((partyTag) => partyTag.value.param)
                    .toSet()
            )
        )
    );
  }

  static Map<Type, List<BillPostTag>> groupByType(List<BillPostTag> tags) {
    final Map<Type, List<BillPostTag>> grouped = {};

    for (var tag in tags) {
      final type = tag.runtimeType;
      grouped.putIfAbsent(type, () => []).add(tag);
    }

    return grouped;
  }

  static List<T> getGroupedListByType<T extends BillPostTag>(
      Map<Type, List<BillPostTag>> original,
      Type targetType) {
    final list = original[targetType];
    if (list == null) {
      return [];
    }
    return list.cast<T>();
  }
}