import 'dart:collection';
import 'package:core/navigation/application_navigation_service.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/notification/domain/entities/received_notificaton.dart';
import 'package:features/notification/presentation/viewmodel/notification_viewmodel.dart';
import 'package:features/shared/view/appbar.dart';
import 'package:features/shared/view/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
          data: (data) {
            if(data.isEmpty) {
              return const Center(child: Text("받은 알림이 없어요", style: TextStylePreset.sectionTitle,));
            }
            return _createItems(data, ref);
          },
          error: (error, stack) => const SomethingWentWrongWidget(),
          loading: () => const Center(child: CircularProgressIndicator(color: ColorPalette.bluePrimary,),)
      )
    );
  }

  Widget _createItems(List<ReceivedNotification> notifications, WidgetRef ref) {
    final readMap = ref.watch(notificationReadStatusProvider);
    final notifier = ref.read(notificationReadStatusProvider.notifier);

    // List<ReceivedNotification> sorted = _sortNotificationItems(notifications, readMap);
    List<ReceivedNotification> sorted = _getUnreadNotifications(notifications, readMap);

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final notification = sorted[index];
        final isRead = readMap[notification.billId] ?? false;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifier.load(notification.billId);
        });

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: double.infinity,
          child: Material(
            color: isRead ? Colors.transparent : const Color(0x88E3F2FD),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification.title, style: TextStylePreset.thumbnailSubtitle),
                          Text(
                              notification.body,
                              style: TextStylePreset.thumbnailTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2
                          ),
                          Text(DateFormat('yy-MM-dd HH:mm').format(notification.receivedAt), style: TextStylePreset.thumbnailSubtitle,),
                        ],
                      ),
                    ),
                    isRead
                        ? const Text("읽음", style: TextStylePreset.thumbnailSubtitle,)
                        : const Icon(Icons.markunread_rounded, color: ColorPalette.orangeLight,),
                    // : Text("신규", style: _notificationNewStyle )
                  ],
                )
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

  List<ReceivedNotification> _getUnreadNotifications(List<ReceivedNotification> notifications, UnmodifiableMapView<String, bool> readMap) {
    return notifications.where((notification) => !(readMap[notification.billId] ?? false))
        .toList()
        ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt)); // 최신순 정렬
  }

  List<ReceivedNotification> _getReadNotifications(List<ReceivedNotification> notifications, UnmodifiableMapView<String, bool> readMap) {
    return notifications.where((notification) => readMap[notification.billId] ?? false)
        .toList()
      ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt)); // 최신순 정렬
  }

  List<ReceivedNotification> _sortNotificationItems(List<ReceivedNotification> notifications, UnmodifiableMapView<String, bool> readMap) {
    final sorted = [...notifications]..sort((a, b) {
      final aIsRead = readMap[a.billId] ?? false;
      final bIsRead = readMap[b.billId] ?? false;

      if (aIsRead != bIsRead) return aIsRead ? 1 : -1;
      return b.receivedAt.compareTo(a.receivedAt);
    });
    return sorted;
  }
}
