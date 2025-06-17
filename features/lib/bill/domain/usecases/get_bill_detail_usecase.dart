import 'package:features/bill/domain/entities/bill_detail.dart';
import 'package:features/bill/domain/repositories/bill_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBillDetailUseCase {

  final BillDetailRepository _billDetailRepository;

  GetBillDetailUseCase({required BillDetailRepository billDetailRepository})
      : _billDetailRepository = billDetailRepository;

  Future<BillDetail> fetch(String billId) {
    return _billDetailRepository.getBillDetail(billId);
  }
}