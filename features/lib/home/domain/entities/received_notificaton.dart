class ReceivedNotification {

  final String _topic;
  final String _title;
  final String _body;
  final String _billId;
  final DateTime _receivedAt;

  ReceivedNotification({
    required String topic,
    required String title,
    required String body,
    required String billId,
    required DateTime receivedAt
  }): _topic = topic,
      _title = title,
      _body = body,
      _billId = billId,
      _receivedAt = receivedAt;

  DateTime get receivedAt => _receivedAt;

  String get body => _body;

  String get title => _title;

  String get topic => _topic;

  String get billId => _billId;
}