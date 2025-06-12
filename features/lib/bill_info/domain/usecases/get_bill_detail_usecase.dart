import 'package:features/bill_info/domain/entities/bill_detail.dart';
import 'package:features/bill_info/domain/repositories/bill_repository.dart';

class GetBillDetailUseCase {

  final BillDetailRepository _billDetailRepository;

  GetBillDetailUseCase({required BillDetailRepository billDetailRepository})
      : _billDetailRepository = billDetailRepository;

  Future<BillDetail> fetch(String billId) {
    return _billDetailRepository.getBillDetail(billId);
  }
}