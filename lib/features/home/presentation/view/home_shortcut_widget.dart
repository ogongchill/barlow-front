import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';

class HomeShortcutWidget extends StatelessWidget {
  const HomeShortcutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _createColumn();
  }

  Column _createColumn() {
    return Column(
      children: [
        _createCard(
            SvgPicture.asset('assets/icons/app/icon_최근접수법안보러가기.svg'),
            "최근 접수 법안 보러가기",
            () => ApplicationNavigatorService.pushToRecentBill()),
        _createCard(
            SvgPicture.asset('assets/icons/app/icon_입법예고보러가기.svg'),
            "진행중인 입법예고 보러가기",
            () => ApplicationNavigatorService.pushToPreAnnounce()),
      ],
    );
  }

  Card _createCard(Widget icon, String description, Function onTapFunction) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(top: 10),
      color: ColorPalette.innerContent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        leading: SizedBox(
          width: 32,
          height: 32,
          child: icon,
        ),
        title: Text(
          description,
          style: TextStylePreset.tab,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          onTapFunction();
        },
      ),
    );
  }
}