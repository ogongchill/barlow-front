import 'package:core/dependency/dependency_container.dart';
import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/entities/signup_option.dart';
import 'package:features/signup/presentation/util/error_dialog.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_notifier.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_state.dart';
import 'package:features/signup/presentation/widget/submit_bar_widget.dart';
import 'package:features/signup/presentation/widget/terms_body_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 회원가입 약관 동의 화면.
///
/// [option]과 [terms]를 전달받아 [termAgreementProvider]를 초기화한다.
/// 사용자가 필수 약관에 모두 동의하면 '가입하기' 버튼이 활성화된다.
class SignupTermsScreen extends ConsumerStatefulWidget {
  final SignupOption option;
  final List<TermAgreementItem> terms;
  final String nickname;

  const SignupTermsScreen({
    super.key,
    required this.option,
    required this.terms,
    required this.nickname,
  });

  @override
  ConsumerState<SignupTermsScreen> createState() =>
      _SignupTermsScreenState();
}

class _SignupTermsScreenState
    extends ConsumerState<SignupTermsScreen> {
  late final TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.nickname);
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
        _handleOauthSignupError(context, ref, next);
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
          : TermsBodyWidget(
              idle: idle,
              nicknameController: _nicknameController,
              onToggleAll: () =>
                  ref.read(termAgreementProvider.notifier).toggleAll(),
              onToggleTerm: (id) =>
                  ref.read(termAgreementProvider.notifier).toggleTerm(id),
            ),
      bottomNavigationBar: SubmitBarWidget(
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
      await showSignupErrorDialog(
          context: context,
          title: '닉네임을 입력해주세요.',
          message: '닉네임은 빈칸으로 생성 할 수 없습니다',
          onPressed: () => Navigator.of(context).pop());
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

  Future<void> _handleOauthSignupError(
    BuildContext context,
    WidgetRef ref,
    TermAgreementError error,
  ) async {
    ref.read(termAgreementProvider.notifier).resetToIdle();
    await showSignupErrorDialog(
        context: context,
        title: "계정을 가입할 수 없습니다 :(",
        message: error.message,
        onPressed: () => ApplicationNavigatorService.goToOnBoarding());
  }
}
