import 'package:design_system/theme/color_palette.dart';
import 'package:features/home/presentation/viewmodel/home_view_provider.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppbar extends ConsumerWidget implements PreferredSizeWidget {

  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildAppBarWithNotification(context, ref);
    // return _buildAppBar(context);
  }

  Widget _buildAppBar(BuildContext context, ) {
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
              icon: const Icon(Icons.notifications)
          )
        ],
      ),
    );
  }

  Widget _buildAppBarWithNotification(BuildContext context, WidgetRef ref) {
    final homeInfo = ref.watch(getHomeInfoFutureProvider);
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
          Stack(
            children: [
              IconButton(
                  onPressed: ()=> ApplicationNavigatorService.pushToNotificationCenter(),
                  icon:const Icon(Icons.notifications, size: 30,)
              ),
              homeInfo.when(
                  data: (data) => data.isNotificationArrived
                      ? const Positioned(
                          top: 5, right: 0,
                          child: Icon(Icons.fiber_new_rounded, color: ColorPalette.orangeDeep, size: 20,),
                        )
                      : const SizedBox.shrink(),
                  error: (stack, error) => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink()
              )
            ],
          ),
        ],
      ),
    );
  }
}
