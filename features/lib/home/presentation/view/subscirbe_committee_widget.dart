// import 'package:design_system/theme/color_palette.dart';
// import 'package:design_system/theme/test_style_preset.dart';
// import 'package:features/home/domain/entities/committee_account.dart';
// import 'package:features/home/presentation/viewmodel/home_view_provider.dart';
// import 'package:features/navigation/application_navigation_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shimmer/shimmer.dart';
//
// import 'subscribed_committee_list_view.dart';
//
// class SubscribeCommitteeWidget extends ConsumerWidget {
//
//   const SubscribeCommitteeWidget({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final asyncValue = ref.watch(getHomeInfoFutureProvider);
//     return asyncValue.when(
//         data: (subscribeAccounts) {
//           if(asyncValue.isLoading) {
//             _buildWith(_buildSkeletonLoader(),ref);
//           }
//           return _buildWith(_buildInnerContainer(subscribeAccounts.subscriptions),ref);
//         },
//         error: (err, stack) {
//           print(err);
//          return _buildWith(_buildFetchFail(), ref);
//         },
//         loading: () => _buildWith(_buildSkeletonLoader(),ref)
//     );
//   }
//
//   Column _buildWith(Widget innerContent, WidgetRef ref) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start, // 제목 왼쪽 정렬
//       children: [
//       _buildTitle(),
//       innerContent,
//       _buildBottomCommitteeButton(ref)
//       ],
//     );
//   }
//
//   Widget _buildSkeletonLoader() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!, // 어두운 회색
//       highlightColor: Colors.grey[100]!, // 밝은 회색
//       child: Container(
//         padding: EdgeInsets.zero,
//         margin: EdgeInsets.zero,
//         width: double.infinity,
//         height: 200,
//         decoration: const BoxDecoration(
//           color: Colors.white, // Shimmer가 덮어씌우므로 큰 의미 없음
//           borderRadius: BorderRadius.zero,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTitle() {
//     return Container(
//         margin: const EdgeInsets.only(top: 30),
//         padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
//             color: ColorPalette.innerContent
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 좌우 끝 정렬
//           children: [
//             Container(
//               margin: const EdgeInsets.only(left: 10),
//               child: const Text("내 구독 목록", style: TextStylePreset.sectionTitle),
//             )
//           ],
//         )
//     );
//   }
//
//   Widget _buildBottomCommitteeButton(WidgetRef ref) {
//     return Card(
//         clipBehavior: Clip.hardEdge,
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.zero, topRight: Radius.zero,
//                 bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)
//             )
//         ),
//         margin: const EdgeInsets.only(bottom: 30),
//         color: ColorPalette.innerContent, // 배경색 추가
//         child: ListTile(
//           contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//           title: const Text(
//             "상임위원회 더 알아보기",
//             style: TextStylePreset.innerContentSubtitle, // 기존 스타일 적용
//           ),
//           trailing: const Icon(Icons.keyboard_arrow_right_rounded),
//           onTap: () => ApplicationNavigatorService.pushToCommitteeSubscription(ref),
//         )
//     );
//   }
//
//   SingleChildScrollView _buildFetchFail() {
//      return SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           height: 200,
//           margin: const EdgeInsets.all(0),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: const BoxDecoration(
//             color: ColorPalette.innerContent,
//             borderRadius: BorderRadius.zero,
//           ),
//           alignment: Alignment.center,
//           child:
//           const Text("상임위원회 조회에 실패했습니다", style: TextStylePreset.listElement),
//         )
//      );
//   }
//
//   SingleChildScrollView _buildInnerContainer(List<SubscribeCommitteeInfo> subscribeAccounts) {
//     if (subscribeAccounts.isEmpty) {
//       return SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             height: 200,
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: const BoxDecoration(
//               color: ColorPalette.innerContent,
//               borderRadius: BorderRadius.zero,
//             ),
//             alignment: Alignment.center,
//             child: const Text("관심있는 상임위원회가 없습니다", style: TextStylePreset.innerContentLight),
//           ));
//     }
//     return SingleChildScrollView(
//         child: SubscribeCommitteeListView(accounts: subscribeAccounts));
//   }
// }
