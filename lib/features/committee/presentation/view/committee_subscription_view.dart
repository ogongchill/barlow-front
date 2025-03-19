import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/view/committe_subscription_list_widget.dart';
import 'package:front/features/committee/presentation/view/committee_susbcription_appbar_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';

class CommitteeSubscriptionView extends ConsumerWidget{

  const CommitteeSubscriptionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(committeeSubscriptionFutureProvider);
    return asyncValue.when(
        data: (committeeSubscriptions) => _buildScaffold(committeeSubscriptions),
        error: (exception, stack) => ErrorWidget(exception),
        loading: () => Text("is loading")
    );
  }

  Scaffold _buildScaffold(List<CommitteeSubscription> subscriptions) {
    return Scaffold(
      appBar: CommitteeSubscriptionAppbarWidget(title: "상임위원회 알아보기"),
      body: CommitteeSubscriptionWidget(committeeSubscriptions: subscriptions),
    );
  }
}
