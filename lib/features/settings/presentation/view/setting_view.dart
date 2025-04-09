import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/settings/presentation/view/notification_widget.dart';
import 'package:front/features/settings/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/bottom_nav_bar_widget.dart';
import 'package:front/features/shared/view/error.dart';

class SettingView extends ConsumerWidget {

  static const TextStyle _headerStyle = TextStyle(
    fontSize: 16,
    fontFamily: "gmarketSans",
    fontWeight: FontWeight.w500,
    color: ColorPalette.borderBlack
  );

  static const TextStyle _idStyle = TextStyle(
      fontSize: 18,
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      color: ColorPalette.borderBlack
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
              const NotificationWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Text("내 정보", style: _headerStyle,)
        ),
        Container(
          padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPalette.innerContent
          ),
          child: Row(
            spacing: 30,
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
              userInfo.when(
                  data: (userInfo) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child:Text(userInfo.role.name, style: _headerStyle,),
                        ),
                        Text(userInfo.userId, style: _idStyle,)
                      ],
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
}