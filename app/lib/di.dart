import 'package:core/dependency/dependency_container.dart';
import 'package:core/dependency//core_injection.module.dart';
import 'package:core/dependency/environment.dart';
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
  dependencyContainer.init(environment: targetEnv);
}
