import 'package:core/dependency/dependency_container.dart';
import 'package:features/bill/domain/entities/preannounce_bill_detail.dart';
import 'package:features/bill/domain/usecases/fetch_preannounce_bill_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preAnnounceBillDetailProvider = FutureProvider.family.autoDispose<PreAnnounceBillDetail, String>( (ref, billId) async {
  final FetchPreAnnounceBillDetailUseCase useCase = dependencyContainer<FetchPreAnnounceBillDetailUseCase>();
  return await useCase.execute(billId);
});