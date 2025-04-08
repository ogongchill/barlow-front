import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/view/committe_subscription_list_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/bottom_nav_bar_widget.dart';

class CommitteeSubscriptionView extends ConsumerWidget{

  const CommitteeSubscriptionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(committeeSubscriptionFutureProvider);
    return asyncValue.when(
        data: (committeeSubscriptions) => _buildScaffold(committeeSubscriptions, context),
        error: (exception, stack) => ErrorWidget(exception),
        loading: () => Text("is loading")
    );
  }

  Scaffold _buildScaffold(List<CommitteeSubscription> subscriptions, BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: TextAppBar(
          title: "상임위원회 알아보기",
          onPressedBack: () => ApplicationNavigatorService.popWithResult(context)
      ),
      bottomNavigationBar: const ApplicationBottomNavigationBarWidget(),
      body: _buildBody(subscriptions),
    );
  }

  Widget _buildBody(List<CommitteeSubscription> committeeSubscriptions) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: ColorPalette.innerContent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: const Text(
            """
상임위원회는 국회에서 입법안을 심사하고 조정하는 핵심 기구예요. 

법안이 발의되면 해당 상임위원회에서 검토하고 수정하여 본회의에 상정할지를 결정해요. 

또한, 법률안의 세부 조항을 조정하고 관련 정부 부처와 협의하는 역할도 맡고 있어요.""",
            style: TextStylePreset.innerContentLight
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: ColorPalette.innerContent,
              borderRadius: BorderRadius.circular(10)
          ),
          child: CommitteeSubscriptionWidget(committeeSubscriptions: committeeSubscriptions)
        ),
      ],
    );
  }
}
