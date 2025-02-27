import 'package:flutter_svg/flutter_svg.dart';

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