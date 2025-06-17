import 'dart:ui';
import 'package:flutter_svg/svg.dart';

enum PartyCard {
  reform(PartyCardBackgroundContainer.reform, PartyCardNameTagContainer.reform, "개혁신당"),
  peoplePower(PartyCardBackgroundContainer.peoplePower, PartyCardNameTagContainer.peoplePower, "국민의힘"),
  basicIncome(PartyCardBackgroundContainer.basicIncome, PartyCardNameTagContainer.basicIncome, "기본소득당"),
  democratic(PartyCardBackgroundContainer.democratic, PartyCardNameTagContainer.democratic, "더불어민주당"),
  socialDemocratic(PartyCardBackgroundContainer.socialDemocratic, PartyCardNameTagContainer.socialDemocratic, "사회민주당"),
  rebuildingKorea(PartyCardBackgroundContainer.rebuildingKorea, PartyCardNameTagContainer.rebuildingKorea, "조국혁신당"),
  progressive(PartyCardBackgroundContainer.progressive, PartyCardNameTagContainer.progressive, "진보당"),
  independent(PartyCardBackgroundContainer.independent, PartyCardNameTagContainer.independent, "무소속"),
  ;

  final PartyCardBackgroundContainer background;
  final PartyCardNameTagContainer nameTag;
  final String korName;

  const PartyCard(this.background, this.nameTag, this.korName);

  static PartyCard findByName(String targetName) => values.firstWhere((card) => card.korName == targetName);

  SvgPicture getNameTag({double? size, Color? color}) => nameTag.toSvgPicture(size: size, color: color);

  SvgPicture getCard({double? size, Color? color}) => background.toSvgPicture(size: size, color: color);
}

class PartyCardBackgroundContainer {

  final String _path;

  const PartyCardBackgroundContainer._(this._path);

  static const PartyCardBackgroundContainer reform = PartyCardBackgroundContainer._('assets/cards/개혁신당_card.svg');
  static const PartyCardBackgroundContainer peoplePower = PartyCardBackgroundContainer._('assets/cards/국민의힘_card.svg');
  static const PartyCardBackgroundContainer basicIncome = PartyCardBackgroundContainer._('assets/cards/기본소득당_card.svg');
  static const PartyCardBackgroundContainer democratic = PartyCardBackgroundContainer._('assets/cards/더불어민주당_card.svg');
  static const PartyCardBackgroundContainer socialDemocratic = PartyCardBackgroundContainer._('assets/cards/사회민주당_card.svg');
  static const PartyCardBackgroundContainer rebuildingKorea = PartyCardBackgroundContainer._('assets/cards/조국혁신당_card.svg');
  static const PartyCardBackgroundContainer progressive = PartyCardBackgroundContainer._('assets/cards/진보당_card.svg');
  static const PartyCardBackgroundContainer independent = PartyCardBackgroundContainer._('assets/cards/무소속_card.svg');

  static const List<PartyCardBackgroundContainer> values = [
    reform,
    peoplePower,
    basicIncome,
    democratic,
    socialDemocratic,
    rebuildingKorea,
    progressive,
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

class PartyCardNameTagContainer {

  final String _path;

  const PartyCardNameTagContainer._(this._path);

  static const PartyCardNameTagContainer reform = PartyCardNameTagContainer._('assets/cards/개혁신당_name_tag_card.svg');
  static const PartyCardNameTagContainer peoplePower = PartyCardNameTagContainer._('assets/cards/국민의힘_name_tag_card.svg');
  static const PartyCardNameTagContainer basicIncome = PartyCardNameTagContainer._('assets/cards/기본소득당_name_tag_card.svg');
  static const PartyCardNameTagContainer democratic = PartyCardNameTagContainer._('assets/cards/더불어민주당_name_tag_card.svg');
  static const PartyCardNameTagContainer socialDemocratic = PartyCardNameTagContainer._('assets/cards/사회민주당_name_tag_card.svg');
  static const PartyCardNameTagContainer rebuildingKorea = PartyCardNameTagContainer._('assets/cards/조국혁신당_name_tag_card.svg');
  static const PartyCardNameTagContainer progressive = PartyCardNameTagContainer._('assets/cards/진보당_name_tag_card.svg');
  static const PartyCardNameTagContainer independent = PartyCardNameTagContainer._('assets/cards/무소속_name_tag_card.svg');

  static const List<PartyCardNameTagContainer> values = [
    reform,
    peoplePower,
    basicIncome,
    democratic,
    socialDemocratic,
    rebuildingKorea,
    progressive,
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


//
//
// class PartyCard {
//
//   final String _cardPath;
//   final String _nameTagPath;
//   final Party party;
//
//   const PartyCard._(this._cardPath, this._nameTagPath, this.party);
//
//   static const PartyCard reformParty = PartyCard._(
//       'assets/cards/개혁신당_card.svg',
//       'assets/cards/개혁신당_name_tag_card.svg',
//       Party.reform
//   );
//   static const PartyCard peoplePowerParty = PartyCard._(
//       'assets/cards/국민의힘_card.svg',
//       'assets/cards/국민의힘_name_tag_card.svg',
//       Party.peoplePower
//   );
//   static const PartyCard basicIncomeParty = PartyCard._(
//       'assets/cards/기본소득당_card.svg',
//       'assets/cards/기본소득당_name_tag_card.svg',
//       Party.basicIncome
//   );
//   static const PartyCard democraticParty = PartyCard._(
//       'assets/cards/더불어민주당_card.svg',
//       'assets/cards/더불어민주당_name_tag_card.svg',
//       Party.democratic
//   );
//   static const PartyCard socialDemocraticParty = PartyCard._(
//       'assets/cards/사회민주당_card.svg',
//       'assets/cards/사회민주당_name_tag_card.svg',
//       Party.socialDemocratic
//   );
//   static const PartyCard progressiveParty = PartyCard._(
//       'assets/cards/진보당_card.svg',
//       'assets/cards/진보당_name_tag_card.svg',
//       Party.progressive
//   );
//   static const PartyCard rebuildingKoreaParty = PartyCard._(
//       'assets/cards/조국혁신당_card.svg',
//       'assets/cards/조국혁신당_name_tag_card.svg',
//       Party.rebuildingKorea
//   );
//   static const PartyCard independent = PartyCard._(
//       'assets/cards/무소속_card.svg',
//       'assets/cards/무소속_name_tag_card.svg',
//       Party.independent
//   );
//
//   static const List<PartyCard> values = [
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
//   static findByParty(Party party) => values.firstWhere(
//           (partyCard) => partyCard.party == party, orElse: () => independent);
//
//   SvgPicture getCard({double? width, double? height, Color? color}) => SvgPicture.asset(
//     _cardPath,
//     width: width,
//     height: height,
//     colorFilter: color != null
//         ? ColorFilter.mode(color, BlendMode.srcIn)
//         : null,
//   );
//
//   SvgPicture getNameTag({double? size, Color? color}) => SvgPicture.asset(
//     _nameTagPath,
//     width: size,
//     height: size,
//     colorFilter: color != null
//         ? ColorFilter.mode(color, BlendMode.srcIn)
//         : null,
//   );
// }