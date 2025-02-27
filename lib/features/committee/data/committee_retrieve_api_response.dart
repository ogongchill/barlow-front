import 'package:front/features/committee/data/committee_account.dart';

class CommitteeRetrieveApiResponse {
  final String _title;
  final String _subtitle;
  final String _description;
  final List<CommitteeAccount> _accounts;

  CommitteeRetrieveApiResponse(
      this._title,
      this._subtitle,
      this._description,
      this._accounts);

  factory CommitteeRetrieveApiResponse.fromJson(Map<String, dynamic> json) {
    return CommitteeRetrieveApiResponse(
        json['title'],
        json['subtitle'],
        json['description'],
        List<CommitteeAccount>.from(json['accounts'] ?? []));
  }

  String get description => _description;

  String get subtitle => _subtitle;

  String get title => _title;

  List<CommitteeAccount> get accounts => _accounts;
}
