import 'package:core/api/constants/bill_proposer_param.dart';

enum BillProposerType {

  government("정부", "GOVERNMENT", BillProposerParam.government),
  chairman("위원장", "CHAIRMAN", BillProposerParam.chairman),
  speaker("의장", "SPEAKER", BillProposerParam.speaker),
  lawmaker("의원", "LAWMAKER", BillProposerParam.lawmaker),
  etc("기타", "ETC", BillProposerParam.etc)
  ;

  final String _value;
  final String _upperCaseWithUnderscore;
  final BillProposerParam param;

  const BillProposerType(this._value, this._upperCaseWithUnderscore, this.param);

  String get value => _value;
  String get upperCaseWithUnderscore => param.value;
}