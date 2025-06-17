import 'package:features/splash/domain/usecases/generate_random_nickname_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nicknameProvider = FutureProvider<String>((ref) => GenerateRandomNicknameUseCase.instance.execute());