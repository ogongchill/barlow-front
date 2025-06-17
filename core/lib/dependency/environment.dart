import 'package:injectable/injectable.dart';

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}

const dev = Environment('dev');
const prod = Environment('prod');