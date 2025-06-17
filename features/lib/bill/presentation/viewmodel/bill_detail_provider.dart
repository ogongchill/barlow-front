import 'package:core/dependency/dependency_container.dart';
import 'package:features/bill/domain/entities/bill_detail.dart';
import 'package:features/bill/domain/usecases/get_bill_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getBillDetailUseCaseProvider = Provider<GetBillDetailUseCase>((ref) {
  return dependencyContainer<GetBillDetailUseCase>();
});

final getBillDetailFutureProvider = FutureProvider.family<BillDetail, String>( (ref, billId) async {
  final useCase = ref.watch(getBillDetailUseCaseProvider);
  return await useCase.fetch(billId);
});