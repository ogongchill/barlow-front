import 'package:features/bill/domain/entities/preannounce_bill_detail.dart';

abstract interface class PreAnnounceBillDetailRepository {

  Future<PreAnnounceBillDetail> retrieve({required String billId});
}