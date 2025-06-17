import 'package:features/bill/domain/entities/bill_detail.dart';
import 'package:features/bill/domain/entities/bill_detail_sections.dart';

class PreAnnounceBillDetail {

  final String title;
  final String legislativeBody;
  final String detail;
  final String proposerSummary;
  final PreAnnouncementSection preAnnouncementSection;
  BillProposerSection? proposerSection;
  BillAiSummary? summarySection;

  PreAnnounceBillDetail({
    required this.title,
    required this.legislativeBody,
    required this.detail,
    required this.proposerSummary,
    required this.preAnnouncementSection,
    this.proposerSection,
    this.summarySection
  });
}

class PreAnnouncementSection {

  final DateTime deadline;
  final int dDAy;
  String? linkUrl;

  PreAnnouncementSection({required this.deadline, this.linkUrl, required this.dDAy});
}