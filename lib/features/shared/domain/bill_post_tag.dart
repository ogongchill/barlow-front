import 'package:front/features/shared/domain/bill_progress_status.dart';
import 'package:front/features/shared/domain/bill_proposer_type.dart';
import 'package:front/features/shared/domain/party.dart';

abstract class BillPostTag<T> {

  final String _tagName;
  final T _value;

  BillPostTag({required String tagName, required T value})
      : _tagName = tagName,
        _value = value;

  String get tagName => _tagName;

  T get value => _value;

  String getValueAsString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BillPostTag &&
              runtimeType == other.runtimeType &&
              _tagName == other._tagName &&
              _value == other._value;

  @override
  int get hashCode => _tagName.hashCode ^ _value.hashCode;
}

class ProgressStatusTag extends BillPostTag<ProgressStatus> {

  static const _name = "progressStatus";

  ProgressStatusTag._({required ProgressStatus status})
      : super(tagName: _name, value: status);

  //접수
  static ProgressStatusTag received = ProgressStatusTag._(status: ProgressStatus.received);
  //소관위 접수
  static ProgressStatusTag committeeReceived = ProgressStatusTag._(status: ProgressStatus.received);
  //대안반영폐기
  static ProgressStatusTag replacedAndDiscarded = ProgressStatusTag._(status: ProgressStatus.replacedAndDiscarded);
  //체계자구심사
  static ProgressStatusTag systematicWordingReview = ProgressStatusTag._(status: ProgressStatus.systematicWordingReview);
  //본회의 의부 안건
  static ProgressStatusTag plenarySubmitted = ProgressStatusTag._(status: ProgressStatus.plenarySubmitted);
  //본회의 의결
  static ProgressStatusTag plenaryDecided = ProgressStatusTag._(status: ProgressStatus.plenaryDecided);
  //철회
  static ProgressStatusTag withDrawn = ProgressStatusTag._(status: ProgressStatus.withdrawn);
  //정부이송
  static ProgressStatusTag governmentTransferred = ProgressStatusTag._(status: ProgressStatus.governmentTransferred);
  //재의요구
  static ProgressStatusTag redemandRequested = ProgressStatusTag._(status: ProgressStatus.redemandRequested);
  //공포
  static ProgressStatusTag promulgated = ProgressStatusTag._(status: ProgressStatus.promulgated);

  static List<ProgressStatusTag> getTagsAfterPlenarySubmitted() {
    return [
      plenaryDecided,
      withDrawn,
      governmentTransferred,
      redemandRequested,
      promulgated
    ];
  }

  @override
  String getValueAsString() {
    return super._value.name;
  }
}

class PartyTag extends BillPostTag<Party> {

  static const String _name = "party";

  PartyTag._({required Party party})
      : super(tagName : _name, value : party);

  static PartyTag reform = PartyTag._(party: Party.reform); // 개혁신당
  static PartyTag peoplePower = PartyTag._(party: Party.peoplePower); //국민의힘
  static PartyTag basicIncome = PartyTag._(party: Party.basicIncome); //기본소득당
  static PartyTag democratic = PartyTag._(party: Party.democratic); // 더불어민주당
  static PartyTag socialDemocratic = PartyTag._(party: Party.socialDemocratic); // 사회민주당
  static PartyTag progressive = PartyTag._(party: Party.progressive); // 진보당
  static PartyTag rebuildingKorea = PartyTag._(party: Party.rebuildingKorea); // 조국혁신당
  static PartyTag independent = PartyTag._(party: Party.independent); // 무소속

  @override
  String getValueAsString() {
    return _value.name;
  }

  static List<PartyTag> getAll() {
    return [
      reform,
      peoplePower,
      basicIncome,
      democratic,
      socialDemocratic,
      progressive,
      rebuildingKorea,
      independent
    ];
  }
}

class BillProposerTypeTag extends BillPostTag<BillProposerType> {

  static const String _name = "billProposerType";

  BillProposerTypeTag._({required BillProposerType billProposerType})
   : super(tagName: _name, value: billProposerType);

  static BillProposerTypeTag government = BillProposerTypeTag._(billProposerType: BillProposerType.government);
  static BillProposerTypeTag chairman = BillProposerTypeTag._(billProposerType: BillProposerType.chairman);
  static BillProposerTypeTag speaker = BillProposerTypeTag._(billProposerType: BillProposerType.speaker);
  static BillProposerTypeTag lawmaker = BillProposerTypeTag._(billProposerType: BillProposerType.lawmaker);
  static BillProposerTypeTag etc = BillProposerTypeTag._(billProposerType: BillProposerType.etc);

  @override
  String getValueAsString() {
    return super._value.value;
  }

  static List<BillProposerTypeTag> getAll() {
    return [
      government,
      chairman,
      speaker,
      lawmaker,
      etc
    ];
  }
}