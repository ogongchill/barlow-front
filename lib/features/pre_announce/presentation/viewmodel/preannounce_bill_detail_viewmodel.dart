import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:front/features/pre_announce/domain/usecases/fetch_preannounce_bill_detail_usecase.dart';

final preAnnounceBillDetailProvider = FutureProvider.family.autoDispose<PreAnnounceBillDetail, String>( (ref, billId) async {
  final FetchPreAnnounceBillDetailUseCase useCase = getIt<FetchPreAnnounceBillDetailUseCase>();
  return await useCase.execute(billId);
});