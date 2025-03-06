import '../../domain/entities/committee_account.dart';
import '../../domain/usecases/get_subscribe_committee_usecase.dart';


enum CommitteeAccountRetrieveState { initial, empty, loaded, error }

class CommitteeAccountProvider {

  final GetSubscribeCommitteeUseCase _getSubscribedCommitteeAccountUseCase;
  CommitteeAccountRetrieveState _state = CommitteeAccountRetrieveState.initial;
  List<SubscribeCommitteeInfo> _accounts = [];
  String? _errorMessage;

  CommitteeAccountProvider({required GetSubscribeCommitteeUseCase useCase})
      : _getSubscribedCommitteeAccountUseCase = useCase;

  CommitteeAccountRetrieveState get state => _state;
  List<SubscribeCommitteeInfo> get accounts => _accounts;
  String? get errorMessage => _errorMessage;

  Future<void> retrieve() async {
    try {
      final response = await _getSubscribedCommitteeAccountUseCase.fetch();
      _accounts = response;
      _state = _accounts.isEmpty ? CommitteeAccountRetrieveState.empty : CommitteeAccountRetrieveState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = CommitteeAccountRetrieveState.error;
    }
  }
}
