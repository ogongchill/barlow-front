import 'package:core/api/common/params/query_parameter.dart';

class SortKeyQueryParam extends QueryParameter{

  SortKeyQueryParam(SortKey sortKey) : super({'sort': sortKey.value});
}

enum SortKey {

  createdAtDesc("createdAt#DESC"),
  createdAtAsc("createdAt#ASC"),
  ;

  final String value;

  const SortKey(this.value);
}