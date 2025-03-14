import 'package:front/features/shared/domain/party.dart';

class BillDetail {

  final String _title;
  final String _proposerSummary;
  final String _proposerType;
  final DateTime _createdAt;
  final String _detail;
  final String? _legislativeBody;
  final BillAiSummary? _summarySection;
  final BillProposerSection? _proposerSection;

  BillDetail({
    required String title,
    required String proposerSummary,
    required String proposerType,
    required String legislativeBody,
    required DateTime createdAt,
    required String detail,
    required summarySection,
    required proposerSection})
      : _title = title,
        _proposerSummary = proposerSummary,
        _proposerType = proposerType,
        _legislativeBody = legislativeBody,
        _createdAt = createdAt,
        _detail = detail,
        _summarySection = summarySection,
        _proposerSection = proposerSection;

  BillAiSummary? get summarySection => _summarySection;

  String get detail => _detail;

  DateTime get createdAt => _createdAt;

  String? get legislativeBody => _legislativeBody;

  String get proposerType => _proposerType;

  String get proposerSummary => _proposerSummary;

  String get title => _title;

  BillProposerSection? get proposerSection => _proposerSection;
}

class BillAiSummary {

  final String _title;
  final String _detail;

  BillAiSummary({required String title, required String detail})
      : _title = title,
        _detail = detail;

  String get title => _title;

  String get detail => _detail;
}

class BillProposerSection {

  final BillProposerRate _billProposerRate;
  final List<BillProposer> _billProposers;

  BillProposerSection({required BillProposerRate billProposerRate, required List<BillProposer> billProposers})
      : _billProposers = billProposers,
        _billProposerRate = billProposerRate;

  List<BillProposer> get billProposer => _billProposers;

  BillProposerRate get billProposerRate => _billProposerRate;
}

class BillProposerRate {

  final Map<Party, int> _proposerPartyRate;

  BillProposerRate({required Map<Party, int> proposerRate})
      : _proposerPartyRate = proposerRate;

  static BillProposerRate fromPartyName(Map<String, int> proposerRate) {
    Map<Party, int> converted = proposerRate.map((key, value) => MapEntry(Party.findByName(key), value));
    return BillProposerRate(proposerRate: converted);
  }

  Map<Party, int> get value => _proposerPartyRate;
}

class BillProposer {

  final String _name;
  final String _profileImage;
  final Party _party;

  BillProposer({required String name, required String profileImage, required String partyName})
      : _name = name,
        _profileImage = profileImage,
        _party = Party.findByName(partyName);

  Party get party => _party;

  String get profileImage => _profileImage;

  String get name => _name;
}