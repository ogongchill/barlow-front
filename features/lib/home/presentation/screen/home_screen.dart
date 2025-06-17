import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/home/presentation/view/subscribed_committee_list_view.dart';
import 'package:features/home/presentation/widgets/home_appbar.dart';
import 'package:features/home/presentation/widgets/home_shortcut_widget.dart';
import 'package:features/home/presentation/view/today_bill_thumbnail_view.dart';
import 'package:features/home/presentation/viewmodel/home_view_provider.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/shared/presentation/widget/bottom_nav_bar_widget.dart';
import 'package:features/shared/presentation/widget/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.read(homeRefreshTriggerProvider.notifier).state = !ref.read(homeRefreshTriggerProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeInfo = ref.watch(getHomeInfoFutureProvider);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorPalette.background,
        appBar: const HomeAppbar(),
        bottomNavigationBar: const ApplicationBottomNavigationBarWidget(),
        body: RefreshIndicator(
          color: ColorPalette.bluePrimary,
          backgroundColor: ColorPalette.whitePrimary,
          onRefresh: () => _refresh(ref),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 10, left:10, right: 10),
            children: homeInfo.when(
                data: (data) => [
                  const HomeShortcutWidget(),
                  _buildSubscribeCommitteeSection(SubscribeCommitteeListView(accounts: data.subscriptions), ref),
                  _buildTodayThumbnailSection(TodayBillThumbnailWidget(data.thumbnails))
                ],
                error: (err, stack)  {
                  print("[ERR] : ${err.toString()}");
                  return [
                  const HomeShortcutWidget(),
                  _buildSubscribeCommitteeSection(const SomethingWentWrongWidget(), ref),
                  _buildTodayThumbnailSection(const SomethingWentWrongWidget())
                  ];
                },
                loading: () => [
                  const HomeShortcutWidget(),
                  _buildSubscribeCommitteeSection(_buildSkeletonLoader(), ref),
                  _buildTodayThumbnailSection(_buildSkeletonLoader())
                ]
            ),
          ),
        ),
      ),
    );
  }

  Column _buildSubscribeCommitteeSection(Widget subscribeCommittees, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 제목 왼쪽 정렬
      children: [
        _buildTitle(),
        subscribeCommittees,
        _buildBottomCommitteeButton(ref)
      ],
    );
  }

  Widget _buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // 어두운 회색
      highlightColor: Colors.grey[100]!, // 밝은 회색
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white, // Shimmer가 덮어씌우므로 큰 의미 없음
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: ColorPalette.innerContent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 좌우 끝 정렬
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("내 구독 목록", style: TextStylePreset.sectionTitle),
            )
          ],
        )
    );
  }

  Widget _buildBottomCommitteeButton(WidgetRef ref) {
    return Card(
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.zero, topRight: Radius.zero,
                bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)
            )
        ),
        margin: const EdgeInsets.only(bottom: 30),
        color: ColorPalette.innerContent, // 배경색 추가
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          title: const Text(
            "상임위원회 더 알아보기",
            style: TextStylePreset.innerContentSubtitle, // 기존 스타일 적용
          ),
          trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          onTap: () => ApplicationNavigatorService.pushToCommitteeSubscription(ref),
        )
    );
  }

  Widget _buildTodayThumbnailSection(Widget innerContent) {
    return Column(
      children: [
        _buildTodayThumbnailTitle(),
        innerContent,
      ],
    );
  }

  Widget _buildTodayThumbnailTitle() {
    return Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: ColorPalette.innerContent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 좌우 끝 정렬
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("오늘 접수된 법안", style: TextStylePreset.sectionTitle),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // 기본 텍스트 색상
                  overlayColor: Colors.grey.withOpacity(0.2), // ✅ 클릭 효과 색상을 회색으로 설정
                ),
                onPressed: ()  => ApplicationNavigatorService.pushToRecentBill() ,
                child: const Text("더보기",style: TextStylePreset.thumbnailSubtitle,
                )
            ),
          ],
        )
    );
  }
}