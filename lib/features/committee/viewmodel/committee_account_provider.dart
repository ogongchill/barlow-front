import 'package:flutter/cupertino.dart';
import 'package:front/features/committee/data/committee_retrieve_api_repository.dart';
import 'package:front/features/committee/data/committee_retrieve_api_response.dart';

enum CommitteeAccountRetrieveState { initial, loading, empty, loaded, error }

class CommitteeAccountProvider with ChangeNotifier {

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
    if (_state == CommitteeAccountRetrieveState.loading) return; // 중복 호출 방지
    _state = CommitteeAccountRetrieveState.loading;
    notifyListeners(); //  UI에 즉시 반영 (로딩 상태)
    await _fetchAndSetState();
    notifyListeners(); //  최종적으로 한 번만 호출 (최적화)
  }

  Future<void> _fetchAndSetState() async {
    try {
      final response = await _repository.retrieve();
      _data = response;
      if (response.accounts.isEmpty) {
        _state = CommitteeAccountRetrieveState.empty;
      } else {
        _state = CommitteeAccountRetrieveState.loaded;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _state = CommitteeAccountRetrieveState.error;
    }
  }
}
