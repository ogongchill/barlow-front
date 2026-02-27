import 'package:core/dependency/dependency_container.dart';
import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/entities/signup_option.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_notifier.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// 회원가입 약관 동의 화면.
///
/// [option]과 [terms]를 전달받아 [termAgreementProvider]를 초기화한다.
/// 사용자가 필수 약관에 모두 동의하면 '가입하기' 버튼이 활성화된다.
class KakaoSignupTermsScreen extends ConsumerStatefulWidget {
  final SignupOption option;
  final List<TermAgreementItem> terms;

  const KakaoSignupTermsScreen({
    super.key,
    required this.option,
    required this.terms,
  });

  @override
  ConsumerState<KakaoSignupTermsScreen> createState() =>
      _KakaoSignupTermsScreenState();
}

class _KakaoSignupTermsScreenState
    extends ConsumerState<KakaoSignupTermsScreen> {
  final _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(termAgreementProvider.notifier)
          .initialize(widget.option, widget.terms);
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<TermAgreementState>(termAgreementProvider, (previous, next) {
      if (next is TermAgreementSuccess) {
        ApplicationNavigatorService.goToHome();
      } else if (next is TermAgreementError) {
        _showErrorSnackBar(context, next.message);
        ref.read(termAgreementProvider.notifier).resetToIdle();
      }
    });

    final state = ref.watch(termAgreementProvider);
    final idle = state is TermAgreementIdle ? state : null;
    final isLoading = state is TermAgreementLoading;

    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        backgroundColor: ColorPalette.innerContent,
        elevation: 0,
        title: const Text(
          '서비스 이용 약관',
          style: TextStyle(
            fontFamily: 'gmarketSans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorPalette.textHead,
          ),
        ),
        leading: const BackButton(color: ColorPalette.textHead),
      ),
      body: idle == null
          ? const Center(child: CircularProgressIndicator())
          : _TermsBody(
              idle: idle,
              nicknameController: _nicknameController,
              onToggleAll: () =>
                  ref.read(termAgreementProvider.notifier).toggleAll(),
              onToggleTerm: (id) =>
                  ref.read(termAgreementProvider.notifier).toggleTerm(id),
            ),
      bottomNavigationBar: _SubmitBar(
        canSubmit: idle?.canSubmit ?? false,
        isLoading: isLoading,
        onSubmit: (idle?.canSubmit ?? false) && !isLoading
            ? () => _submit()
            : null,
      ),
    );
  }

  Future<void> _submit() async {
    final nickname = _nicknameController.text.trim();
    if (nickname.isEmpty) {
      _showErrorSnackBar(context, '닉네임을 입력해주세요.');
      return;
    }
    final deviceInfo = dependencyContainer<DeviceInfo>();
    final fcmManager = dependencyContainer<FcmManager>();
    final deviceToken = await fcmManager.getToken() ?? '';
    ref.read(termAgreementProvider.notifier).submit(
          nickname: nickname,
          deviceId: deviceInfo.deviceId,
          deviceToken: deviceToken,
          deviceOs: deviceInfo.deviceOs,
        );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'gmarketSans',
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorPalette.greyDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _TermsBody extends StatelessWidget {
  final TermAgreementIdle idle;
  final TextEditingController nicknameController;
  final VoidCallback onToggleAll;
  final void Function(int termId) onToggleTerm;

  const _TermsBody({
    required this.idle,
    required this.nicknameController,
    required this.onToggleAll,
    required this.onToggleTerm,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 닉네임 입력
          Container(
            decoration: BoxDecoration(
              color: ColorPalette.innerContent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorPalette.borderLight),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: nicknameController,
              style: const TextStyle(fontFamily: 'gmarketSans', fontSize: 15),
              decoration: const InputDecoration(
                hintText: '닉네임을 입력해주세요',
                hintStyle: TextStyle(
                  fontFamily: 'gmarketSans',
                  color: ColorPalette.greyDark,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // 전체 동의 토글
          GestureDetector(
            onTap: onToggleAll,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: ColorPalette.innerContent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: idle.isAllAgreed
                      ? ColorPalette.orangePrimary
                      : ColorPalette.borderLight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    idle.isAllAgreed
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded,
                    color: idle.isAllAgreed
                        ? ColorPalette.orangePrimary
                        : ColorPalette.greyDark,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '전체 동의',
                    style: TextStyle(
                      fontFamily: 'gmarketSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 약관 항목 목록
          ...idle.terms.map(
            (term) => _TermItem(
              term: term,
              onToggle: () => onToggleTerm(term.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _TermItem extends StatelessWidget {
  final TermAgreementItem term;
  final VoidCallback onToggle;

  const _TermItem({required this.term, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              term.isAgreed
                  ? Icons.check_circle_rounded
                  : Icons.check_circle_outline_rounded,
              color: term.isAgreed
                  ? ColorPalette.orangePrimary
                  : ColorPalette.greyDark,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              term.title,
              style:
                  const TextStyle(fontFamily: 'gmarketSans', fontSize: 14),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: term.isRequired
                  ? ColorPalette.orangeVeryLight
                  : ColorPalette.greyLight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              term.isRequired ? '필수' : '선택',
              style: TextStyle(
                fontFamily: 'gmarketSans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: term.isRequired
                    ? ColorPalette.orangeDeep
                    : ColorPalette.greyDark,
              ),
            ),
          ),
          if (term.linkUrl.isNotEmpty) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _launchUrl(term.linkUrl),
              child: const Icon(
                Icons.open_in_new,
                size: 16,
                color: ColorPalette.greyDark,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }
}

class _SubmitBar extends StatelessWidget {
  final bool canSubmit;
  final bool isLoading;
  final VoidCallback? onSubmit;

  const _SubmitBar({
    required this.canSubmit,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onSubmit,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              decoration: BoxDecoration(
                color: canSubmit
                    ? ColorPalette.orangePrimary
                    : ColorPalette.greyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                height: 52,
                alignment: Alignment.center,
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        '가입하기',
                        style: TextStyle(
                          fontFamily: 'gmarketSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color:
                              canSubmit ? Colors.white : ColorPalette.greyDark,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
