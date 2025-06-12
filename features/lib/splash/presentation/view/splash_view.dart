import 'package:core/navigation/application_navigation_service.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:features/splash/presentation/view/splash_screen_widget.dart';
import 'package:features/splash/presentation/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashView extends ConsumerWidget {

  static const TextStyle _header = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w500
  );

  static const TextStyle _subtitle = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500
  );

  static const TextStyle _description = TextStyle(
      fontFamily: "gmarketSans",
      color: ColorPalette.greyDark,
      fontSize: 16,
      fontWeight: FontWeight.w500
  );

  static const TextStyle _emoji = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.black,
      fontSize: 50,
      fontWeight: FontWeight.w500
  );

  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appInitializeStateProvider, (prev, next) {
      bool updateTemporaryRejected = ref.read(temporaryDisableUpdateNotifierProvider);
      next.whenData((state) {
        if (state.needForceUpdate) {
          _showForceUpdateDialog(context, ref);
        } else if (state.isUpdateAvailable && !state.hasRejectUpdateDialog && !updateTemporaryRejected) {
          _showUpdateDialog(context, ref);
        } else if (!state.hasCheckNotificationPermission) {
          ApplicationNavigatorService.goToPermissions();
        } else if (state.isFirstLaunch || !state.isLoggedIn) {
          ApplicationNavigatorService.goToOnBoarding();
        } else {
          ApplicationNavigatorService.goToHome();
        }
      });
    });
    return const SplashScreenWidget();
  }

  Future<void> _showForceUpdateDialog(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Column(
          children: [
            SizedBox(height: 80, child: Text(":(", style: _emoji,),),
            Text("업데이트가 필요해요", style: _header, textAlign: TextAlign.center,),
            SizedBox(height: 40,),
            Divider()
          ],
        ),
        content: const Text("현재 버전은 지원되지 않습니다. 스토어에 방문하여 업데이트를 해주세요.", style: _subtitle,),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text("스토어로 이동", style: _description,),
                  Icon(Icons.arrow_circle_right_rounded, color: Colors.greenAccent, size: 24,),
                ],
              )
          ),
        ],
      ),
    );
    // 다이얼로그 닫힌 후 처리
    if (result == false || result == null) {// "나중에" 클릭 or 바깥 터치로 dismiss
      ref.read(appInitializeStateProvider.notifier).setRefreshFlag();
    } else if (result == true) {
      // "업데이트" 클릭
      final url = ref.read(storeUrlProvider);
      ref.read(appInitializeStateProvider.notifier).setRefreshFlag();
      _openExternalBrowser(url);
    }
  }

  Future<void> _showUpdateDialog(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Column(
          children: [
            SizedBox(height: 100, child: Icon(Icons.fiber_new_rounded, color: ColorPalette.orangePrimary, size: 50,),),
            Text("새로운 버전이 있어요", style: _header, textAlign: TextAlign.center,),
            SizedBox(height: 40,),
            Divider()
          ],
        ),
        content: const Text("최신 기능을 사용하려면 업데이트해보세요.", style: _subtitle,),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // "나중에"
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text("나중에 할래요", style: _description,),
                Icon(Icons.disabled_by_default_rounded, color: Colors.redAccent, size: 24,),
              ],
            )
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text("스토어로 이동", style: _description,),
                  Icon(Icons.arrow_circle_right_rounded, color: Colors.greenAccent, size: 24,),
                ],
              )
          ),
        ],
      ),
    );

    // 다이얼로그 닫힌 후 처리
    if (result == false) {// "나중에" 클릭
      ref.read(appInitializeStateProvider.notifier).markRejectUpdateDialog();
    } else if(result == null) { //dismiss
      ref.read(temporaryDisableUpdateNotifierProvider.notifier).execute();
      ref.read(appInitializeStateProvider.notifier).setRefreshFlag();
    } else if (result == true) {// "업데이트" 클릭
      final url = ref.read(storeUrlProvider);
      ref.read(appInitializeStateProvider.notifier).setRefreshFlag();
      _openExternalBrowser(url);
    }
  }

  void _openExternalBrowser(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw 'URL 실행 불가: $url';
    }
  }
}
