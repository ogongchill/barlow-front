import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/core/navigation/application_navigation_service.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {

  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(top: 0, left: 20, right: 10, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/icons/app/app_icon_바로.svg',
            width: 50,
          ),
          IconButton(
              onPressed: ()=> ApplicationNavigatorService.pushToNotificationCenter(),
              icon: Icon(Icons.notifications)
          )
        ],
      ),
    );
  }
}
