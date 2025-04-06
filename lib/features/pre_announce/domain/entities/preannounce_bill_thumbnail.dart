import 'package:front/features/shared/domain/bill_thumbnail.dart';

class PreAnnounceBillThumbnail extends BillThumbnail{

  final int _dDay;

  PreAnnounceBillThumbnail({
    required super.billId,
    required super.billName,
    required super.proposers,
    super.legislativeBody,
    required int dDay})
    : _dDay = dDay;

  int get dDay => _dDay;
}