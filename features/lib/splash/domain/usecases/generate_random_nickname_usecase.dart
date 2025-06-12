import 'package:features/splash/domain/serivce/random_nickname_generator.dart';

class GenerateRandomNicknameUseCase {

  static final GenerateRandomNicknameUseCase instance = GenerateRandomNicknameUseCase._(RandomNicknameGenerator.instance);
  final RandomNicknameGenerator _generator;

  GenerateRandomNicknameUseCase._(RandomNicknameGenerator generator): _generator = generator;

  Future<String> execute() async {
    return _generator.getRandom();
  }
}