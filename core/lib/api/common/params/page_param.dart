import 'package:core/api/common/params/query_parameter.dart';

class PageQueryParam extends QueryParameter{

  PageQueryParam(int page, int size)
  : super({
    'page': page,
    'size': size
  });
}
