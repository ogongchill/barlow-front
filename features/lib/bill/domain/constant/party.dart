import 'package:core/api/constants/party_param.dart';

class Party {

  static const Party reform = Party._("개혁신당", PartyParam.reform);
  static const Party peoplePower = Party._("국민의힘", PartyParam.peoplePower);
  static const Party basicIncome = Party._("기본소득당", PartyParam.basicIncome);
  static const Party democratic = Party._("더불어민주당", PartyParam.democratic);
  static const Party socialDemocratic = Party._("사회민주당", PartyParam.socialDemocratic);
  static const Party progressive = Party._("진보당", PartyParam.progressive);
  static const Party rebuildingKorea = Party._("조국혁신당", PartyParam.rebuildingKorea);
  static const Party independent = Party._("무소속", PartyParam.independent);

  static final Map<String, Party> _partyMap = {
    "개혁신당" : reform,
    "국민의힘" : peoplePower,
    "기본소득당" : basicIncome,
    "더불어민주당" : democratic,
    "사회민주당" : socialDemocratic,
    "진보당" : progressive,
    "조국혁신당" : rebuildingKorea,
    "무소속" : independent
  };

  final String _name;
  final PartyParam _param;

  const Party._(this._name, this._param);

  String get name => _name;
  PartyParam get param => _param;

  static Party findByName(String name) {
    if(_partyMap.containsKey(name)) {
      return _partyMap[name]!;
    }
    throw StateError("no such Party name : $name");
  }
}