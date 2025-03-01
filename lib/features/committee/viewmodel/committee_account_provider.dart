import 'package:front/features/committee/data/committee_retrieve_api_repository.dart';
import 'package:front/features/committee/data/committee_retrieve_api_response.dart';

enum CommitteeAccountRetrieveState { initial, empty, loaded, error }

class CommitteeAccountProvider {

  final CommitteeRetrieveApiRepository _repository;
  CommitteeAccountRetrieveState _state = CommitteeAccountRetrieveState.initial;
  CommitteeRetrieveApiResponse? _data;
  String? _errorMessage;

  CommitteeAccountProvider({required CommitteeRetrieveApiRepository repository})
      : _repository = repository;

  CommitteeAccountRetrieveState get state => _state;
  CommitteeRetrieveApiResponse? get data => _data;
  String? get errorMessage => _errorMessage;

  Future<void> retrieve() async {
    try {
      final response = await _repository.retrieve();
      _data = response;
      _state = response.accounts.isEmpty ? CommitteeAccountRetrieveState.empty : CommitteeAccountRetrieveState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = CommitteeAccountRetrieveState.error;
    }
  }
}
