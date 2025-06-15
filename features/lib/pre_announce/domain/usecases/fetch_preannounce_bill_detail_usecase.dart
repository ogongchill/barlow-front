import 'package:features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:features/pre_announce/domain/repositories/preannounce_bill_detail_respository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchPreAnnounceBillDetailUseCase {

  final PreAnnounceBillDetailRepository _repository;

  FetchPreAnnounceBillDetailUseCase({required PreAnnounceBillDetailRepository repository})
    : _repository = repository;

  Future<PreAnnounceBillDetail> execute(String billId) {
    return _repository.retrieve(billId: billId);
  }
}