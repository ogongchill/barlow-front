import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/settings/domain/usecases/request_open_app_setting_usecase.dart';

final openAppSettingProvider = Provider<void Function()>((ref) => RequestOpenAppSettingUseCase().execute);