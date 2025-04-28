
import 'package:front/core/api/common/api_request_params.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/page.dart';

class BillPostTagParamProcessor {

  static BillPostParams composeFrom(Page page, List<BillPostTag> tags) {
    final grouped = groupByType(tags);
    return BillPostParams.from(
        pagingParam: PagingParam(page.index, page.size),
        billPostFilterParam: BillPostFilterParam(
            legislationType: LegislationFilterTag(
                getGroupedListByType<CommitteeTag>(grouped, CommitteeTag)
                    .map((committeeTag) => CommitteeLegislationType.of(committeeTag.value))
                    .toSet()
            ),
            progressStatus: ProgressStatusFilter(
                getGroupedListByType<ProgressStatusTag>(grouped, ProgressStatusTag)
                    .map((progressStatusTag) => progressStatusTag.value)
                    .toSet()
            ),
            proposerType: ProposerTypeFilter(
                getGroupedListByType<BillProposerTypeTag>(grouped, BillProposerTypeTag)
                    .map((proposerTag) => proposerTag.value)
                    .toSet()
            ),
            partyName: PartyNameFilter(
                getGroupedListByType<PartyTag>(grouped, PartyTag)
                    .map((partyTag) => partyTag.value)
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