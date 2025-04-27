import 'package:front/core/api/common/api_request_params.dart';

enum PreAnnounceSortKey {

  deadlineAsc("SORT_DEADLINE_ASC"), // 마감순
  deadlineDesc("SORT_DEADLINE_DESC"), // 마감 늦는 순
  ;

  final String value;

  const PreAnnounceSortKey(this.value);
}

class PreAnnounceParam {

  final Map<String, dynamic> _params;

  PreAnnounceParam._(this._params);

  factory PreAnnounceParam.from({PagingParam? pagingParam, PreAnnounceSortKey? preAnnounceSortKey, BillPostFilterParam? billPostFilterParam}) {
    Map<String, dynamic> params = {};
    if(pagingParam!=null) {
      params.addAll(pagingParam.pagingParam);
    }
    if(preAnnounceSortKey!=null) {
      params['sort'] = preAnnounceSortKey.value;
    }
    if(billPostFilterParam!=null) {
      params.addAll(billPostFilterParam.toMap());
    }
    return PreAnnounceParam._(params);
  }

  Map<String, dynamic> get params => _params;
}