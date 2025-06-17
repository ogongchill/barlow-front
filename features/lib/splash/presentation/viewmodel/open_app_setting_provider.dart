import 'package:features/settings/domain/usecases/request_open_app_setting_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final openAppSettingProvider = Provider<void Function()>((ref) => RequestOpenAppSettingUseCase().execute);