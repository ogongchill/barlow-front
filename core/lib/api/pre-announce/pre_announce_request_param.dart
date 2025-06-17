import 'package:core/api/common/params/api_request_params.dart';
import 'package:core/api/common/params/page_param.dart';

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

  factory PreAnnounceParam.from({PageQueryParam? pagingParam, PreAnnounceSortKey? preAnnounceSortKey, BillPostFilterParam? billPostFilterParam}) {
    Map<String, dynamic> params = {};
    if(pagingParam!=null) {
      params.addAll(pagingParam.value);
    }
    if(preAnnounceSortKey!=null) {
      params['sort'] = preAnnounceSortKey.value;
    }
    if(billPostFilterParam!=null) {
      params.addAll(billPostFilterParam.value);
    }
    return PreAnnounceParam._(params);
  }

  Map<String, dynamic> get params => _params;
}