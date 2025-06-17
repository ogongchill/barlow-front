import 'package:design_system/package_path.dart';

enum PartyCard {

  reform('$packagePath/assets/cards/개혁신당_card.svg', '$packagePath/assets/cards/개혁신당_name_tag_card.svg'),
  peoplePower('$packagePath/assets/cards/국민의힘_card.svg', '$packagePath/assets/cards/국민의힘_name_tag_card.svg' ),
  basicIncome('$packagePath/assets/cards/기본소득당_card.svg', '$packagePath/assets/cards/기본소득당_name_tag_card.svg' ),
  democratic('$packagePath/assets/cards/더불어민주당_card.svg', '$packagePath/assets/cards/더불어민주당_name_tag_card.svg' ),
  socialDemocratic('$packagePath/assets/cards/사회민주당_card.svg', '$packagePath/assets/cards/사회민주당_name_tag_card.svg' ),
  rebuildingKorea('$packagePath/assets/cards/조국혁신당_card.svg', '$packagePath/assets/cards/조국혁신당_name_tag_card.svg' ),
  progressive('$packagePath/assets/cards/진보당_card.svg', '$packagePath/assets/cards/진보당_name_tag_card.svg' ),
  independent('$packagePath/assets/cards/무소속_card.svg', '$packagePath/assets/cards/무소속_name_tag_card.svg' ),
  ;

  final String background;
  final String nameTag;

  const PartyCard(this.background, this.nameTag);
}
