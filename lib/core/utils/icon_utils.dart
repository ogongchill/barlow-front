import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/features/shared/domain/party.dart';

class CommitteeIconContainer {

  static final SvgPicture defaultIcon = SvgPicture.asset("/assets/icons/committee/국회운영위원회.svg");
  static final Map<String, SvgPicture> _svgIcons = {
    "국회운영위원회" : SvgPicture.asset("assets/icons/committee/icon_국회운영위원회.svg"),
    "법제사법위원회" : SvgPicture.asset( "assets/icons/committee/icon_법제사법위원회.svg"),
    "정무위원회" : SvgPicture.asset("assets/icons/committee/icon_정무위원회.svg"),
    "기획재정위원회" : SvgPicture.asset("assets/icons/committee/icon_기획재정위원회.svg"),
    "교육위원회" : SvgPicture.asset("assets/icons/committee/icon_교육위원회.svg"),
    "과학기술정보방송통신위원회" : SvgPicture.asset("assets/icons/committee/icon_과학기술정보방송통신위원회.svg"),
    "외교통일위원회" : SvgPicture.asset("assets/icons/committee/icon_외교통일위원회.svg"),
    "국방위원회" : SvgPicture.asset("assets/icons/committee/icon_국방위원회.svg"),
    "행정안전위원회" : SvgPicture.asset("assets/icons/committee/icon_행정안전위원회.svg"),
    "문화체육관광위원회" : SvgPicture.asset("assets/icons/committee/icon_문화체육관광위원회.svg"),
    "농림축산식품해양수산위원회": SvgPicture.asset("assets/icons/committee/icon_농림축산식품해양수산위원회.svg"),
    "산업통상자원중소벤처기업위원회" : SvgPicture.asset("assets/icons/committee/icon_산업통상자원중소벤처기업위원회.svg"),
    "보건복지위원회" : SvgPicture.asset("assets/icons/committee/icon_보건복지위원회.svg"),
    "환경노동위원회" : SvgPicture.asset("assets/icons/committee/icon_환경노동위원회.svg"),
    "국토교통위원회" : SvgPicture.asset("assets/icons/committee/icon_국토교통위원회.svg"),
    "정보위원회" : SvgPicture.asset("assets/icons/committee/icon_정보위원회.svg"),
    "여성가족위원회" : SvgPicture.asset("assets/icons/committee/icon_여성가족위원회.svg"),
    "예산결산특별위원회" : SvgPicture.asset("assets/icons/committee/icon_예산결산특별위원회.svg")
  };

  static SvgPicture findByName(String name) {
    return _svgIcons[name] ?? defaultIcon;
  }
}

class CommitteeIcon {

  final String _path;

  const CommitteeIcon._(this._path);

  static const CommitteeIcon houseSteering = CommitteeIcon._('assets/icons/committee/icon_국회운영위원회.svg');
  static const CommitteeIcon legislationAndJudiciary = CommitteeIcon._('assets/icons/committee/icon_법제사법위원회.svg');
  static const CommitteeIcon nationalPolicy = CommitteeIcon._('assets/icons/committee/icon_정무위원회.svg');
  static const CommitteeIcon strategyAndFinance = CommitteeIcon._('assets/icons/committee/icon_기획재정위원회.svg');
  static const CommitteeIcon education = CommitteeIcon._('assets/icons/committee/icon_교육위원회.svg');
  static const CommitteeIcon scienceIctBroadcastingAndCommunications = CommitteeIcon._('assets/icons/committee/icon_과학기술정보방송통신위원회.svg');
  static const CommitteeIcon foreignAffairsAndUnification = CommitteeIcon._('assets/icons/committee/icon_외교통일위원회.svg');
  static const CommitteeIcon nationalDefense = CommitteeIcon._('assets/icons/committee/icon_국방위원회.svg');
  static const CommitteeIcon publicAdministrationAndSecurity = CommitteeIcon._('assets/icons/committee/icon_행정안전위원회.svg');
  static const CommitteeIcon cultureSportsAndTourism = CommitteeIcon._('assets/icons/committee/icon_문화체육관광위원회.svg');
  static const CommitteeIcon agricultureFoodRuralAffairsOceansAndFisheries = CommitteeIcon._('assets/icons/committee/icon_농림축산식품해양수산위원회.svg');
  static const CommitteeIcon tradeIndustryEnergySmesAndStartups = CommitteeIcon._('assets/icons/committee/icon_산업통상자원중소벤처기업위원회.svg');
  static const CommitteeIcon healthAndWelfare = CommitteeIcon._('assets/icons/committee/icon_보건복지위원회.svg');
  static const CommitteeIcon environmentAndLabor = CommitteeIcon._('assets/icons/committee/icon_환경노동위원회.svg');
  static const CommitteeIcon landInfrastructureAndTransport = CommitteeIcon._('assets/icons/committee/icon_국토교통위원회.svg');
  static const CommitteeIcon intelligence = CommitteeIcon._('assets/icons/committee/icon_정보위원회.svg');
  static const CommitteeIcon genderEqualityFamily = CommitteeIcon._('assets/icons/committee/icon_여성가족위원회.svg');
  static const CommitteeIcon specialCommitteeOnBudgetAccounts = CommitteeIcon._('assets/icons/committee/icon_예산결산특별위원회.svg');

  static const List<CommitteeIcon> values = [
    houseSteering,
    legislationAndJudiciary,
    nationalPolicy,
    strategyAndFinance,
    education,
    scienceIctBroadcastingAndCommunications,
    foreignAffairsAndUnification,
    nationalDefense,
    publicAdministrationAndSecurity,
    cultureSportsAndTourism,
    agricultureFoodRuralAffairsOceansAndFisheries,
    tradeIndustryEnergySmesAndStartups,
    healthAndWelfare,
    environmentAndLabor,
    landInfrastructureAndTransport,
    intelligence,
    genderEqualityFamily,
    specialCommitteeOnBudgetAccounts
  ];

  SvgPicture toSvgPicture({double size = 24.0, Color? color}) => SvgPicture.asset(
    _path,
    width: size,
    height: size,
    colorFilter: color != null
        ? ColorFilter.mode(color, BlendMode.srcIn)
        : null,
  );
}

class PartyIcon {

  final String _path;

  const PartyIcon._(this._path);

  static const PartyIcon reformParty = PartyIcon._('assets/icons/party/icon_개혁신당.svg');
  static const PartyIcon peoplePowerParty = PartyIcon._('assets/icons/party/icon_국민의힘.svg');
  static const PartyIcon basicIncomeParty = PartyIcon._('assets/icons/party/icon_기본소득당.svg');
  static const PartyIcon democraticParty = PartyIcon._('assets/icons/party/icon_더불어민주당.svg');
  static const PartyIcon socialDemocraticParty = PartyIcon._('assets/icons/party/icon_사회민주당.svg');
  static const PartyIcon progressiveParty = PartyIcon._('assets/icons/party/icon_진보당.svg');
  static const PartyIcon rebuildingKoreaParty = PartyIcon._('assets/icons/party/icon_조국혁신당.svg');
  static const PartyIcon independent = PartyIcon._('assets/icons/party/icon_무소속.svg');

  // ✅ 모든 아이콘을 리스트로 관리 (필요할 경우)
  static const List<PartyIcon> values = [
    reformParty,
    peoplePowerParty,
    basicIncomeParty,
    democraticParty,
    socialDemocraticParty,
    progressiveParty,
    rebuildingKoreaParty,
    independent
  ];

  SvgPicture toSvgPicture({double? size, Color? color}) => SvgPicture.asset(
    _path,
    width: size,
    height: size,
    colorFilter: color != null
        ? ColorFilter.mode(color, BlendMode.srcIn)
        : null,
  );
}

class PartyCard {

  final String _cardPath;
  final String _nameTagPath;
  final Party party;

  const PartyCard._(this._cardPath, this._nameTagPath, this.party);

  static const PartyCard reformParty = PartyCard._(
      'assets/cards/개혁신당_card.svg',
      'assets/cards/개혁신당_name_tag_card.svg',
      Party.reform
  );
  static const PartyCard peoplePowerParty = PartyCard._(
      'assets/cards/국민의힘_card.svg',
      'assets/cards/국민의힘_name_tag_card.svg',
      Party.peoplePower
  );
  static const PartyCard basicIncomeParty = PartyCard._(
      'assets/cards/기본소득당_card.svg',
      'assets/cards/기본소득당_name_tag_card.svg',
      Party.basicIncome
  );
  static const PartyCard democraticParty = PartyCard._(
      'assets/cards/더불어민주당_card.svg',
      'assets/cards/더불어민주당_name_tag_card.svg',
      Party.democratic
  );
  static const PartyCard socialDemocraticParty = PartyCard._(
      'assets/cards/사회민주당_card.svg',
      'assets/cards/사회민주당_name_tag_card.svg',
      Party.socialDemocratic
  );
  static const PartyCard progressiveParty = PartyCard._(
      'assets/cards/진보당_card.svg',
      'assets/cards/진보당_name_tag_card.svg',
      Party.progressive
  );
  static const PartyCard rebuildingKoreaParty = PartyCard._(
      'assets/cards/조국혁신당_card.svg',
      'assets/cards/조국혁신당_name_tag_card.svg',
      Party.rebuildingKorea
  );
  static const PartyCard independent = PartyCard._(
      'assets/cards/무소속_card.svg',
      'assets/cards/무소속_name_tag_card.svg',
      Party.independent
  );

  static const List<PartyCard> values = [
    reformParty,
    peoplePowerParty,
    basicIncomeParty,
    democraticParty,
    socialDemocraticParty,
    progressiveParty,
    rebuildingKoreaParty,
    independent
  ];

  static findByParty(Party party) => values.firstWhere(
          (partyCard) => partyCard.party == party, orElse: () => independent);

  SvgPicture getCard({double? width, double? height, Color? color}) => SvgPicture.asset(
    _cardPath,
    width: width,
    height: height,
    colorFilter: color != null
        ? ColorFilter.mode(color, BlendMode.srcIn)
        : null,
  );

  SvgPicture getNameTag({double? size, Color? color}) => SvgPicture.asset(
    _nameTagPath,
    width: size,
    height: size,
    colorFilter: color != null
        ? ColorFilter.mode(color, BlendMode.srcIn)
        : null,
  );
}