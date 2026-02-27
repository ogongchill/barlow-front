// import 'package:design_system/theme/color_palette.dart';
// import 'package:features/navigation/application_navigation_service.dart';
// import 'package:features/signup/domain/entities/oidc_signup_info.dart';
// import 'package:features/signup/presentation/viewmodel/kakao_signup_notifier.dart';
// import 'package:features/signup/presentation/viewmodel/kakao_signup_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// /// 카카오 회원가입 버튼 뷰.
// ///
// /// [kakaoSignupProvider]를 감지하여 상태에 따라 UI를 처리한다.
// /// - [KakaoSignupLoading] : 버튼 비활성화 및 로딩 인디케이터 표시
// /// - [KakaoSignupTermsReady] : 약관 동의 화면으로 이동 후 상태를 초기화
// /// - [KakaoSignupError] : 스낵바로 에러 메시지 표시 후 상태를 초기화
// class KakaoLoginView extends ConsumerWidget {
//   const KakaoLoginView({super.key});
//
//   static const _kakaoYellow = Color(0xFFFEE500);
//   static const _kakaoLabel = Color(0xFF191919);
//
//   static const _buttonTextStyle = TextStyle(
//     fontFamily: 'gmarketSans',
//     fontWeight: FontWeight.w700,
//     fontSize: 16,
//     color: _kakaoLabel,
//   );
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen<KakaoSignupState>(kakaoSignupProvider, (previous, next) {
//       if (next is KakaoSignupTermsReady) {
//         _navigateToTerms(ref, next.idToken, next.terms);
//         ref.read(kakaoSignupProvider.notifier).resetToIdle();
//       } else if (next is KakaoSignupError) {
//         _showErrorSnackBar(context, next.message);
//         ref.read(kakaoSignupProvider.notifier).resetToIdle();
//       }
//     });
//
//     final state = ref.watch(kakaoSignupProvider);
//     final isLoading = state is KakaoSignupLoading;
//
//     return _KakaoSignupButton(
//       isLoading: isLoading,
//       onTap: isLoading
//           ? null
//           : () => ref.read(kakaoSignupProvider.notifier).onKakaoLoginButtonTapped(),
//       kakaoYellow: _kakaoYellow,
//       kakaoLabel: _kakaoLabel,
//       buttonTextStyle: _buttonTextStyle,
//     );
//   }
//
//   void _navigateToTerms(
//     WidgetRef ref,
//     String idToken,
//     List<TermAgreementItem> terms,
//   ) {
//     ApplicationNavigatorService.pushToKakaoSignupTerms(
//       idToken: idToken,
//       terms: terms,
//     );
//   }
//
//   void _showErrorSnackBar(BuildContext context, String message) {
//     if (!context.mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(
//             fontFamily: 'gmarketSans',
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: ColorPalette.greyDark,
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }
//
// class _KakaoSignupButton extends StatelessWidget {
//   final bool isLoading;
//   final VoidCallback? onTap;
//   final Color kakaoYellow;
//   final Color kakaoLabel;
//   final TextStyle buttonTextStyle;
//
//   const _KakaoSignupButton({
//     required this.isLoading,
//     required this.onTap,
//     required this.kakaoYellow,
//     required this.kakaoLabel,
//     required this.buttonTextStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Ink(
//           decoration: BoxDecoration(
//             color: isLoading ? kakaoYellow.withValues(alpha: 0.6) : kakaoYellow,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Container(
//             width: double.infinity,
//             height: 52,
//             alignment: Alignment.center,
//             child: isLoading
//                 ? SizedBox(
//                     width: 22,
//                     height: 22,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2.5,
//                       valueColor: AlwaysStoppedAnimation<Color>(kakaoLabel),
//                     ),
//                   )
//                 : Row(
//                     mainAxisSize: MainAxisSize.min,
//                     spacing: 8,
//                     children: [
//                       Icon(Icons.chat_bubble_rounded, color: kakaoLabel, size: 20),
//                       Text('카카오로 회원가입', style: buttonTextStyle),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
