import 'package:front/features/shared/domain/party.dart';

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