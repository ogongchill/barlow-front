import 'package:flutter/cupertino.dart';
import 'package:front/features/committee/data/committee_retrieve_api_repository.dart';
import 'package:front/features/committee/data/committee_retrieve_api_response.dart';

enum CommitteeAccountRetrieveState {
  initial, loading, empty, loaded, error
}

class CommitteeAccountProvider with ChangeNotifier {

  final CommitteeRetrieveApiRepository _repository;
  CommitteeAccountProvider({required CommitteeRetrieveApiRepository repository}) : _repository = repository;
  CommitteeRetrieveApiResponse? _data;
  CommitteeAccountRetrieveState _state = CommitteeAccountRetrieveState.initial;
  String? _errorMessage;

  CommitteeRetrieveApiResponse? get data => _data;
  CommitteeAccountRetrieveState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> retrieve() async {
    _state = CommitteeAccountRetrieveState.loading;
    await _fetchAndSetState();
    notifyListeners();
  }

  Future<void> _fetchAndSetState() async {
     try {
      final response = await _repository.retrieve();
      if (response.accounts.isEmpty) {
        _state = CommitteeAccountRetrieveState.empty; // accounts 비어 있으면 empty 상태
      } else {
        _data = response;
        _state = CommitteeAccountRetrieveState.loaded; // accounts가 존재하면 loaded 상태
      }
    } catch (e) {
      _state = CommitteeAccountRetrieveState.error;
      _errorMessage = e.toString();
    }
  }
}