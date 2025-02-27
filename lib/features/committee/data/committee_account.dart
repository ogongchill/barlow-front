class CommitteeAccount {
  final String _name;
  final String _description;
  final int _legislationAccountNo;
  final bool _isSubscribed;
  final bool _isNotifiable;
  final String _iconUrl;

  CommitteeAccount(this._name,
      this._description,
      this._legislationAccountNo,
      this._isSubscribed,
      this._isNotifiable,
      this._iconUrl
      );

  CommitteeAccount.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _description = json['description'],
        _legislationAccountNo = json['year'],
        _isNotifiable = json['isNotifiable'] == 'true',
        _isSubscribed = json['isSubscribed'] == 'true',
        _iconUrl = json['iconUrl'];

  int get legislationAccountNo => _legislationAccountNo;

  String get description => _description;

  String get iconUrl => _iconUrl;

  String get name => _name;

  bool get isNotifiable => _isNotifiable;

  bool get isSubscribed => _isSubscribed;
}
