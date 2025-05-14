import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/settings/presentation/viewmodel/notification_toggle_viewmodel.dart';

class NotificationWidget extends ConsumerStatefulWidget {

  const NotificationWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => NotificationWidgetState();
}

class NotificationWidgetState extends ConsumerState {

  static const TextStyle _headerStyle = TextStyle(
      fontSize: 16,
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      color: ColorPalette.borderBlack
  );

  static const TextStyle _tagStyle = TextStyle(
      fontSize: 16,
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      color: ColorPalette.greyDark
  );

  @override
  void initState() {
    super.initState();
    ref.read(notificationToggleProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationToggleProvider);

    final entries = notificationState.notifications.entries.toList();

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Text("상임위원회", style: _headerStyle,)
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: ColorPalette.innerContent,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                final type = entry.key;
                final isEnabled = entry.value;

                return SwitchListTile(
                  title: Text(
                    type.name,
                    style: _tagStyle
                  ),
                  value: isEnabled,
                  onChanged: (_) {
                    if (!notificationState.isToggleEnabled) return;
                    ref.read(notificationToggleProvider.notifier).toggle(type);
                  },
                  activeColor: ColorPalette.bluePrimary,
                  inactiveThumbColor: ColorPalette.greyDark,
                  inactiveTrackColor: ColorPalette.greyLight,
                  tileColor: ColorPalette.innerContent,
                );
              },
            ),
          ),
        )
      ],
   );
  }

}