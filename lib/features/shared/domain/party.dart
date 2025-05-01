import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/core/utils/icon_utils.dart';
import 'package:front/core/theme/color_palette.dart';

class Party {

  static const Party reform = Party._("개혁신당", "NEW_REFORM" ,ColorPalette.reformOrange ,PartyIcon.reformParty);
  static const Party peoplePower = Party._("국민의힘", "PEOPLE_POWER",ColorPalette.peoplePowerRed , PartyIcon.peoplePowerParty);
  static const Party basicIncome = Party._("기본소득당", "BASIC_INCOME", ColorPalette.basicIncomeMint, PartyIcon.basicIncomeParty);
  static const Party democratic = Party._("더불어민주당", "MINJOO", ColorPalette.democraticBlue , PartyIcon.democraticParty);
  static const Party socialDemocratic = Party._("사회민주당", "SOCIAL_DEMOCRATIC" , ColorPalette.socialDemocraticOrange , PartyIcon.socialDemocraticParty);
  static const Party progressive = Party._("진보당", "PROGRESSIVE" , ColorPalette.progressivePurple ,PartyIcon.progressiveParty);
  static const Party rebuildingKorea = Party._("조국혁신당", "REBUILDING", ColorPalette.rebuildingKoreaBlue ,PartyIcon.rebuildingKoreaParty);
  static const Party independent = Party._("무소속", "INDEPENDENT", ColorPalette.independent ,PartyIcon.independent);

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
  final String _uppercaseWithUnderscore;
  final Color _color;

  final PartyIcon _icon;

  const Party._(this._name, this._uppercaseWithUnderscore, this._color, this._icon);

  String get name => _name;
  String get uppercaseWithUnderscore => _uppercaseWithUnderscore;
  Color get color => _color;
  SvgPicture get svgPicture => _icon.toSvgPicture();
  SvgPicture toSvgPicture(double? size) => _icon.toSvgPicture(size: size);
  PartyIcon get partyIcon => _icon;

  static Party findByName(String name) {
    if(_partyMap.containsKey(name)) {
      return _partyMap[name]!;
    }
    throw StateError("no such Party name : $name");
  }
}