import 'package:features/shared/domain/bil_detail.dart';

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
    required BillAiSummary?summarySection,
    required BillProposerSection? proposerSection})
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