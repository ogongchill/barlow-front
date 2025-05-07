import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/splash/domain/usecases/generate_random_nickname_usecase.dart';

final nicknameProvider = FutureProvider<String>((ref) => GenerateRandomNicknameUseCase.instance.execute());