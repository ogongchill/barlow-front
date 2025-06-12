import 'package:core/dependency/service_locator.dart';
import 'package:features/bill_info/domain/entities/bill_detail.dart';
import 'package:features/bill_info/domain/usecases/get_bill_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getBillDetailUseCaseProvider = Provider<GetBillDetailUseCase>((ref) {
  return getIt<GetBillDetailUseCase>();
});

final getBillDetailFutureProvider = FutureProvider.family<BillDetail, String>( (ref, billId) async {
  final useCase = ref.watch(getBillDetailUseCaseProvider);
  return await useCase.fetch(billId);
});