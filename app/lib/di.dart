import 'package:core/dependency/service_locator.dart';
import 'package:core/di/core_injection.module.dart';
import 'package:core/di/environment.dart';
import 'package:features/features_injection.module.dart';
import 'package:front/di.config.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  externalPackageModulesAfter: [
    ExternalModule(CorePackageModule),
    ExternalModule(FeaturesPackageModule)
  ]
)
void configureDependencies(String? env) {
  String targetEnv = env ?? Env.dev;
  getIt.init(environment: targetEnv);
}
