import 'package:front/features/shared/domain/bill_progress_status.dart';
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

  static List<ProgressStatusTag> getAll() {
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

  PartyTag({required Party party})
      : super(tagName : _name, value : party);

  static PartyTag reform = PartyTag(party: Party.reform); // 개혁신당
  static PartyTag peoplePower = PartyTag(party: Party.peoplePower); //국민의힘
  static PartyTag basicIncome = PartyTag(party: Party.basicIncome); //기본소득당
  static PartyTag democratic = PartyTag(party: Party.democratic); // 더불어민주당
  static PartyTag socialDemocratic = PartyTag(party: Party.socialDemocratic); // 사회민주당
  static PartyTag progressive = PartyTag(party: Party.progressive); // 진보당
  static PartyTag rebuildingKorea = PartyTag(party: Party.rebuildingKorea); // 조국혁신당
  static PartyTag independent = PartyTag(party: Party.independent); // 무소속

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