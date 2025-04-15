import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/notification/domain/entities/received_notificaton.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:front/features/notification/presentation/viewmodel/notification_viewmodel.dart';

class NotificationCenterView extends ConsumerWidget {

  const NotificationCenterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorPalette.innerContent,
      appBar: const TextAppBar(title: "알림"),
      body: Container(child:_buildBody(context, ref)),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final receivedNotifications = ref.watch(receivedNotificationFutureProvider);
    return Container(
      child: receivedNotifications.when(
          data: (data) => _createItems(data, ref),
          error: (error, stack) => const SomethingWentWrongWidget(),
          loading: () => const Center(child: CircularProgressIndicator(color: ColorPalette.bluePrimary,),)
      )
    );
  }

  Widget _createItems(List<ReceivedNotification> notifications, WidgetRef ref) {
    final readMap = ref.watch(notificationReadStatusProvider);
    final notifier = ref.read(notificationReadStatusProvider.notifier);

    final sorted = [...notifications]..sort((a, b) {
      final aIsRead = readMap[a.billId] ?? false;
      final bIsRead = readMap[b.billId] ?? false;

      if (aIsRead != bIsRead) return aIsRead ? 1 : -1;
      return b.receivedAt.compareTo(a.receivedAt);
    });

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final notification = sorted[index];
        final isRead = readMap[notification.billId] ?? false;

        // 읽음 여부 로딩 트리거 (1회)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifier.load(notification.billId);
        });

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Material(
            color: isRead ? Colors.transparent : const Color(0xFFE3F2FD),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder( // ✅ Material도 모양 지정
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 40,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.account_balance_rounded, color: ColorPalette.bluePrimary,),
                        Column(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification.topic, style: TextStylePreset.thumbnailSubtitle),
                            Text(notification.title, style: TextStylePreset.thumbnailTitle),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24,
                      child: isRead
                        ? Text("읽음", style: TextStylePreset.thumbnailSubtitle,)
                        : Icon(Icons.fiber_new_outlined, color: ColorPalette.orangePrimary,)
                    )
                  ],
                ),
              ),
              onTap: () {
                notifier.markAsRead(notification.billId);
                ApplicationNavigatorService.pushToBillDetail(
                  billId: notification.billId,
                  title: "법안",
                );
              },
            ),
          ),
        );
      },
    );
  }
}
