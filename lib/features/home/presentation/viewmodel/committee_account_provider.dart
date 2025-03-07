import 'package:flutter/cupertino.dart';
import 'package:front/core/api/fetch_status.dart';

import 'package:front/features/home/domain/entities/committee_account.dart';
import 'package:front/features/home/domain/usecases/get_subscribe_committee_usecase.dart';

class CommitteeAccountProvider with ChangeNotifier {

  final GetSubscribeCommitteeUseCase _getSubscribedCommitteeAccountUseCase;
  FetchStatus _state = FetchStatus.initial;
  List<SubscribeCommitteeInfo> _accounts = [];
  String? _errorMessage;

  CommitteeAccountProvider({required GetSubscribeCommitteeUseCase useCase})
      : _getSubscribedCommitteeAccountUseCase = useCase;

  FetchStatus get state => _state;
  List<SubscribeCommitteeInfo> get accounts => _accounts;
  String? get errorMessage => _errorMessage;

  Future<void> retrieve() async {
    try {
      final response = await _getSubscribedCommitteeAccountUseCase.fetch();
      _accounts = response;
      _state = _accounts.isEmpty ? FetchStatus.empty : FetchStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = FetchStatus.error;
    }
  }
}
