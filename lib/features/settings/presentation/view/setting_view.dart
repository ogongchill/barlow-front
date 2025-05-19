import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/settings/presentation/viewmodel/delete_guest_user_provider.dart';
import 'package:front/features/settings/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/bottom_nav_bar_widget.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingView extends ConsumerWidget {

  static const TextStyle _roleStyle = TextStyle(
    fontSize: 16,
    fontFamily: "gmarketSans",
    fontWeight: FontWeight.w500,
    color: ColorPalette.borderBlack
  );

  static const TextStyle _nicknameStyle = TextStyle(
      fontSize: 18,
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      color: ColorPalette.borderBlack
  );

  static const TextStyle _idStyle = TextStyle(
      fontSize: 8,
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      color: ColorPalette.greyDark
  );
  static const TextStyle _delete = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.redAccent
  );

  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const TextAppBar(title: "설정"),
      backgroundColor: ColorPalette.background,
      bottomNavigationBar: const ApplicationBottomNavigationBarWidget(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserInfo(ref),
              _settingContents(context, ref)
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingContents(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            margin: const EdgeInsets.only(top: 20),
            child: const Text("설정 ", style: _roleStyle,)
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPalette.innerContent
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text("알림 설정", style: TextStylePreset.thumbnailTitle,),
                  ),
                  IconButton(
                      onPressed: () => ApplicationNavigatorService.pushToNotificationSettings(),
                      icon: const Icon(Icons.keyboard_arrow_right_rounded)
                  )
                ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text("서비스 이용 약관", style: TextStylePreset.thumbnailTitle,),
                    ),
                    TextButton(
                        child: const Text("보기", style: TextStylePreset.thumbnailSubtitle,),
                      onPressed: () => _showWebDialog(context, "서비스 약관", 'https://ogongchill.github.io/barlow/terms-of-service.html'),
                    )
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text("개인정보 처리 방침", style: TextStylePreset.thumbnailTitle,),
                    ),
                    TextButton(
                      child: const Text("보기", style: TextStylePreset.thumbnailSubtitle,),
                      onPressed: () => _showWebDialog(context, "개인정보 처리 방침", 'https://ogongchill.github.io/barlow/privacy-policy.html'),
                    )
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text("계정 삭제", style: TextStylePreset.thumbnailTitle,),
                    ),
                    IconButton(
                        onPressed: () => _confirmDeleteAccount(context, ref),
                        icon: const Icon(Icons.delete_forever_outlined, color: Colors.redAccent,)
                    )
                  ]
              )
            ],
          ),
        ),
      Container(
        padding: const EdgeInsets.all(20),
        child: const Text("""
 ‘바로’ 서비스 내에서 제공되는 법안 정보, 국회의원 발의 현황 등 입법 관련 정보는 「열린국회정보 API」에서 수집하고 있습니다.
  정부 기관 또는 국회를 공식적으로 대변하지 않으며, 
  정보의 정확성이나 최신성에 대해서는 보증하지 않습니다.
  
  문의 : ogogchill@googlegroups.com""",
        style: TextStylePreset.thumbnailSubtitle,
        textAlign: TextAlign.center,),
      ),

      ],
    );
  }

  Widget _buildUserInfo(WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: const Text("내 정보", style: _roleStyle,)
        ),
        Container(
          padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPalette.innerContent
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.greyLight
                ),
                child: const Icon(
                  Icons.manage_accounts,
                  color: ColorPalette.greyDark,
                  size: 40,
                )
              ),
              const SizedBox(width: 30,),
              userInfo.when(
                  data: (userInfo) {
                    return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userInfo.role.name, style: _roleStyle,),
                            Text(userInfo.userName, style: _nicknameStyle,),
                            Text(userInfo.userId, style: _idStyle,)
                          ],
                        )
                    );
                  }, 
                  error: (error, stack) => const SomethingWentWrongWidget(), 
                  loading: () => const CircularProgressIndicator(color: ColorPalette.bluePrimary,)
              )
            ],
          ),
        )
      ],
    );
  }

  Future<void> _confirmDeleteAccount(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('계정 삭제 확인', style: TextStylePreset.appBarTitle, textAlign: TextAlign.center,),
        content: const Text('정말로 계정을 삭제할까요?\n이 작업은 되돌릴 수 없어요.', style: TextStylePreset.innerContentSubtitle,textAlign: TextAlign.center,),
        actions: [
          TextButton(
            child: const Text('취소', style: TextStylePreset.thumbnailTitle,),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('삭제', style: _delete),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    final asyncDelete = await ref.read(deleteGuestUserFutureProvider.future);
    ApplicationNavigatorService.goToSplash();
  }


  Future<void> _showWebDialog(BuildContext context, String title, String url) async {
    final controller = WebViewController()..loadRequest(Uri.parse(url));

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                title: Text(title, style: TextStylePreset.appBarTitle,),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Expanded(
                child: WebViewWidget(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}
