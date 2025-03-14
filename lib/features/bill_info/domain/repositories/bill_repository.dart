import '../entities/bill_detail.dart';

abstract class BillDetailRepository {

  Future<BillDetail> getBillDetail(String billId);
}