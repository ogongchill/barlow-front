import 'package:flutter/material.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';

class ApplicationBottomNavigationBarWidget extends StatelessWidget {

  static const TextStyle _navBarTextStyle = TextStyle(
    fontFamily: "gmarketSans",
    fontSize: 12,
    color: ColorPalette.borderBlack
  );

  const ApplicationBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 80,
      color: ColorPalette.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navigationIcon(
              icon: const Icon(Icons.home_filled), 
              text: "홈",
              onTapFunction: () => ApplicationNavigatorService.goToHome()
          ),
          _navigationIcon(
              icon: const Icon(Icons.account_balance_rounded),
              text: "상임위원회",
              onTapFunction: () => ApplicationNavigatorService.goToCommitteeSubscription()
          ),
          _navigationIcon(
              icon: const Icon(Icons.announcement),
              text: "입법예고",
              onTapFunction: () => ApplicationNavigatorService.pushToPreAnnounce()
          ),
          // _navigationIcon(
          //     icon: const Icon(Icons.people),
          //     text: "국회의원",
          //     onTapFunction: () => ApplicationNavigatorService.pushToDonation()
          // ),
          _navigationIcon(
              icon: const Icon(Icons.settings),
              text: "설정",
              onTapFunction: () => ApplicationNavigatorService.goToSettings()
          )
        ],
      ),
    );
  }

  Widget _navigationIcon({required Widget icon, required String text, required Function onTapFunction}) {
    return Material(
      color: ColorPalette.background,
      child: InkWell(
        onTap: () => onTapFunction(),
        child: SizedBox(
          height: 50,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: icon,
              ),
              Text(text, style: _navBarTextStyle,)
            ],
          ),
        ),
      ),
    );
  }
}