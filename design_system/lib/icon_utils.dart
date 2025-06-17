import 'package:design_system/design_system_exception.dart';
import 'package:design_system/package_path.dart';

enum CommitteeIcons {

  houseSteering('$packagePath/assets/icons/committee/icon_국회운영위원회.svg'),
  legislationAndJudiciary('$packagePath/assets/icons/committee/icon_법제사법위원회.svg'),
  nationalPolicy('$packagePath/assets/icons/committee/icon_정무위원회.svg'),
  strategyAndFinance('$packagePath/assets/icons/committee/icon_기획재정위원회.svg'),
  education('$packagePath/assets/icons/committee/icon_교육위원회.svg'),
  scienceIctBroadcastingAndCommunications('$packagePath/assets/icons/committee/icon_과학기술정보방송통신위원회.svg'),
  foreignAffairsAndUnification('$packagePath/assets/icons/committee/icon_외교통일위원회.svg'),
  nationalDefense('$packagePath/assets/icons/committee/icon_국방위원회.svg'),
  publicAdministrationAndSecurity('$packagePath/assets/icons/committee/icon_행정안전위원회.svg'),
  cultureSportsAndTourism('$packagePath/assets/icons/committee/icon_문화체육관광위원회.svg'),
  agricultureFoodRuralAffairsOceansAndFisheries('$packagePath/assets/icons/committee/icon_농림축산식품해양수산위원회.svg'),
  tradeIndustryEnergySmesAndStartups('$packagePath/assets/icons/committee/icon_산업통상자원중소벤처기업위원회.svg'),
  healthAndWelfare('$packagePath/assets/icons/committee/icon_보건복지위원회.svg'),
  environmentAndLabor('$packagePath/assets/icons/committee/icon_환경노동위원회.svg'),
  landInfrastructureAndTransport('$packagePath/assets/icons/committee/icon_국토교통위원회.svg'),
  intelligence('$packagePath/assets/icons/committee/icon_정보위원회.svg'),
  genderEqualityFamily('$packagePath/assets/icons/committee/icon_여성가족위원회.svg'),
  specialCommitteeOnBudgetAccounts('$packagePath/assets/icons/committee/icon_예산결산특별위원회.svg'),
  ;

  static final Map<String, CommitteeIcons> _map = {
    "국회운영위원회" : CommitteeIcons.houseSteering,
    "법제사법위원회" : CommitteeIcons.legislationAndJudiciary,
    "정무위원회" : CommitteeIcons.nationalPolicy,
    "기획재정위원회" : CommitteeIcons.strategyAndFinance,
    "교육위원회" : CommitteeIcons.education,
    "과학기술정보방송통신위원회" : CommitteeIcons.scienceIctBroadcastingAndCommunications,
    "외교통일위원회" : CommitteeIcons.foreignAffairsAndUnification,
    "국방위원회" : CommitteeIcons.nationalDefense,
    "행정안전위원회" : CommitteeIcons.publicAdministrationAndSecurity,
    "문화체육관광위원회" : CommitteeIcons.cultureSportsAndTourism,
    "농림축산식품해양수산위원회": CommitteeIcons.agricultureFoodRuralAffairsOceansAndFisheries,
    "산업통상자원중소벤처기업위원회" : CommitteeIcons.agricultureFoodRuralAffairsOceansAndFisheries,
    "보건복지위원회" : CommitteeIcons.healthAndWelfare,
    "환경노동위원회" : CommitteeIcons.environmentAndLabor,
    "국토교통위원회" : CommitteeIcons.landInfrastructureAndTransport,
    "정보위원회" : CommitteeIcons.intelligence,
    "여성가족위원회" : CommitteeIcons.genderEqualityFamily,
    "예산결산특별위원회" : CommitteeIcons.specialCommitteeOnBudgetAccounts
  };
  final String path;

  const CommitteeIcons(this.path);

  static CommitteeIcons findByName(String target) =>
      _map[target] ?? (throw DesignSystemException.usage("uknown propoerty: $target"));
}

enum PartyIcons {

  reformParty('$packagePath/assets/icons/party/icon_개혁신당.svg'),
  peoplePowerParty('$packagePath/assets/icons/party/icon_국민의힘.svg'),
  basicIncomeParty('$packagePath/assets/icons/party/icon_기본소득당.svg'),
  democraticParty('$packagePath/assets/icons/party/icon_더불어민주당.svg'),
  socialDemocraticParty('$packagePath/assets/icons/party/icon_사회민주당.svg'),
  progressiveParty('$packagePath/assets/icons/party/icon_진보당.svg'),
  rebuildingKoreaParty('$packagePath/assets/icons/party/icon_조국혁신당.svg'),
  independent('$packagePath/assets/icons/party/icon_무소속.svg'),
  ;

  static final Map<String, PartyIcons> _map = {
    '개혁신당' : PartyIcons.reformParty,
    '국민의힘' : PartyIcons.peoplePowerParty,
    '기본소득당' : PartyIcons.basicIncomeParty,
    '더불어민주당' : PartyIcons.democraticParty,
    '사회민주당' : PartyIcons.socialDemocraticParty,
    '진보당' : PartyIcons.progressiveParty,
    '조국혁신당' : PartyIcons.rebuildingKoreaParty,
    '무소속' : PartyIcons.independent
  };
  final String path;

  const PartyIcons(this.path);

  static PartyIcons findByName(String target) =>
      _map[target] ?? (throw DesignSystemException.usage("uknown propoerty: $target"));
}

//
// class CommitteeIconContainer {
//
//   static final SvgPicture defaultIcon = SvgPicture.asset("/assets/icons/committee/국회운영위원회.svg");
//   static final Map<String, SvgPicture> _svgIcons = {
//     "국회운영위원회" : SvgPicture.asset("assets/icons/committee/icon_국회운영위원회.svg"),
//     "법제사법위원회" : SvgPicture.asset( "assets/icons/committee/icon_법제사법위원회.svg"),
//     "정무위원회" : SvgPicture.asset("assets/icons/committee/icon_정무위원회.svg"),
//     "기획재정위원회" : SvgPicture.asset("assets/icons/committee/icon_기획재정위원회.svg"),
//     "교육위원회" : SvgPicture.asset("assets/icons/committee/icon_교육위원회.svg"),
//     "과학기술정보방송통신위원회" : SvgPicture.asset("assets/icons/committee/icon_과학기술정보방송통신위원회.svg"),
//     "외교통일위원회" : SvgPicture.asset("assets/icons/committee/icon_외교통일위원회.svg"),
//     "국방위원회" : SvgPicture.asset("assets/icons/committee/icon_국방위원회.svg"),
//     "행정안전위원회" : SvgPicture.asset("assets/icons/committee/icon_행정안전위원회.svg"),
//     "문화체육관광위원회" : SvgPicture.asset("assets/icons/committee/icon_문화체육관광위원회.svg"),
//     "농림축산식품해양수산위원회": SvgPicture.asset("assets/icons/committee/icon_농림축산식품해양수산위원회.svg"),
//     "산업통상자원중소벤처기업위원회" : SvgPicture.asset("assets/icons/committee/icon_산업통상자원중소벤처기업위원회.svg"),
//     "보건복지위원회" : SvgPicture.asset("assets/icons/committee/icon_보건복지위원회.svg"),
//     "환경노동위원회" : SvgPicture.asset("assets/icons/committee/icon_환경노동위원회.svg"),
//     "국토교통위원회" : SvgPicture.asset("assets/icons/committee/icon_국토교통위원회.svg"),
//     "정보위원회" : SvgPicture.asset("assets/icons/committee/icon_정보위원회.svg"),
//     "여성가족위원회" : SvgPicture.asset("assets/icons/committee/icon_여성가족위원회.svg"),
//     "예산결산특별위원회" : SvgPicture.asset("assets/icons/committee/icon_예산결산특별위원회.svg")
//   };
//
//   static SvgPicture findByName(String name) {
//     return _svgIcons[name] ?? defaultIcon;
//   }
// }
//
// class CommitteeIcon {
//
//   final String _path;
//
//   const CommitteeIcon._(this._path);
//
//   static const CommitteeIcon houseSteering = CommitteeIcon._('assets/icons/committee/icon_국회운영위원회.svg');
//   static const CommitteeIcon legislationAndJudiciary = CommitteeIcon._('assets/icons/committee/icon_법제사법위원회.svg');
//   static const CommitteeIcon nationalPolicy = CommitteeIcon._('assets/icons/committee/icon_정무위원회.svg');
//   static const CommitteeIcon strategyAndFinance = CommitteeIcon._('assets/icons/committee/icon_기획재정위원회.svg');
//   static const CommitteeIcon education = CommitteeIcon._('assets/icons/committee/icon_교육위원회.svg');
//   static const CommitteeIcon scienceIctBroadcastingAndCommunications = CommitteeIcon._('assets/icons/committee/icon_과학기술정보방송통신위원회.svg');
//   static const CommitteeIcon foreignAffairsAndUnification = CommitteeIcon._('assets/icons/committee/icon_외교통일위원회.svg');
//   static const CommitteeIcon nationalDefense = CommitteeIcon._('assets/icons/committee/icon_국방위원회.svg');
//   static const CommitteeIcon publicAdministrationAndSecurity = CommitteeIcon._('assets/icons/committee/icon_행정안전위원회.svg');
//   static const CommitteeIcon cultureSportsAndTourism = CommitteeIcon._('assets/icons/committee/icon_문화체육관광위원회.svg');
//   static const CommitteeIcon agricultureFoodRuralAffairsOceansAndFisheries = CommitteeIcon._('assets/icons/committee/icon_농림축산식품해양수산위원회.svg');
//   static const CommitteeIcon tradeIndustryEnergySmesAndStartups = CommitteeIcon._('assets/icons/committee/icon_산업통상자원중소벤처기업위원회.svg');
//   static const CommitteeIcon healthAndWelfare = CommitteeIcon._('assets/icons/committee/icon_보건복지위원회.svg');
//   static const CommitteeIcon environmentAndLabor = CommitteeIcon._('assets/icons/committee/icon_환경노동위원회.svg');
//   static const CommitteeIcon landInfrastructureAndTransport = CommitteeIcon._('assets/icons/committee/icon_국토교통위원회.svg');
//   static const CommitteeIcon intelligence = CommitteeIcon._('assets/icons/committee/icon_정보위원회.svg');
//   static const CommitteeIcon genderEqualityFamily = CommitteeIcon._('assets/icons/committee/icon_여성가족위원회.svg');
//   static const CommitteeIcon specialCommitteeOnBudgetAccounts = CommitteeIcon._('assets/icons/committee/icon_예산결산특별위원회.svg');
//
//   static const List<CommitteeIcon> values = [
//     houseSteering,
//     legislationAndJudiciary,
//     nationalPolicy,
//     strategyAndFinance,
//     education,
//     scienceIctBroadcastingAndCommunications,
//     foreignAffairsAndUnification,
//     nationalDefense,
//     publicAdministrationAndSecurity,
//     cultureSportsAndTourism,
//     agricultureFoodRuralAffairsOceansAndFisheries,
//     tradeIndustryEnergySmesAndStartups,
//     healthAndWelfare,
//     environmentAndLabor,
//     landInfrastructureAndTransport,
//     intelligence,
//     genderEqualityFamily,
//     specialCommitteeOnBudgetAccounts
//   ];
//
//   SvgPicture toSvgPicture({double size = 24.0, Color? color}) => SvgPicture.asset(
//     _path,
//     width: size,
//     height: size,
//     colorFilter: color != null
//         ? ColorFilter.mode(color, BlendMode.srcIn)
//         : null,
//   );
// }
//
// class PartyIcon {
//
//   final String _path;
//
//   const PartyIcon._(this._path);
//
//   static const PartyIcon reformParty = PartyIcon._('assets/icons/party/icon_개혁신당.svg');
//   static const PartyIcon peoplePowerParty = PartyIcon._('assets/icons/party/icon_국민의힘.svg');
//   static const PartyIcon basicIncomeParty = PartyIcon._('assets/icons/party/icon_기본소득당.svg');
//   static const PartyIcon democraticParty = PartyIcon._('assets/icons/party/icon_더불어민주당.svg');
//   static const PartyIcon socialDemocraticParty = PartyIcon._('assets/icons/party/icon_사회민주당.svg');
//   static const PartyIcon progressiveParty = PartyIcon._('assets/icons/party/icon_진보당.svg');
//   static const PartyIcon rebuildingKoreaParty = PartyIcon._('assets/icons/party/icon_조국혁신당.svg');
//   static const PartyIcon independent = PartyIcon._('assets/icons/party/icon_무소속.svg');
//
//   static const List<PartyIcon> values = [
//     reformParty,
//     peoplePowerParty,
//     basicIncomeParty,
//     democraticParty,
//     socialDemocraticParty,
//     progressiveParty,
//     rebuildingKoreaParty,
//     independent
//   ];
//
//   SvgPicture toSvgPicture({double? size, Color? color}) => SvgPicture.asset(
//     _path,
//     width: size,
//     height: size,
//     colorFilter: color != null
//         ? ColorFilter.mode(color, BlendMode.srcIn)
//         : null,
//   );
// }