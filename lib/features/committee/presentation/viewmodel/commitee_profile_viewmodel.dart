import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/committee/domain/entities/committee_profile.dart';
import 'package:front/features/committee/domain/usecases/commitee_profile_usecase.dart';
import 'package:front/features/shared/domain/committee.dart';

final committeeProfileFutureProvider = FutureProvider.family.autoDispose<CommitteeProfile, Committee>((ref, committee) async {
  final useCase = getIt<FetchCommitteeProfileUseCase>();
  return useCase.execute(committee);
});
