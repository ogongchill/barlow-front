import 'package:flutter/material.dart';
import 'package:front/core/navigation/application_navigation_service.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {

  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("barlow"),
          IconButton(
              onPressed: ()=> ApplicationNavigatorService.pushToNotificationCenter(),
              icon: Icon(Icons.notifications)
          )
        ],
      ),
    );
  }
}
