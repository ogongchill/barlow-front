import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/dependency/service_locator.dart';

import 'features/home/presentation/view/committee_home_view.dart';

void main() {
  setupLocator();
  runApp(
    ProviderScope( child: MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: ColorPalette.bluePrimary,
            onPrimary: ColorPalette.blueDeep,
            secondary: ColorPalette.orangePrimary,
            onSecondary: ColorPalette.orangeLight,
            error: ColorPalette.orangeDeep,
            onError: ColorPalette.orangeDeep,
            surface: ColorPalette.background,
            onSurface: ColorPalette.innerContent,
            ),
      ),
      debugShowCheckedModeBanner: true,
      home: CommitteeHomeView(),)
  ));
}
