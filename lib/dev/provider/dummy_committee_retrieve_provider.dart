import 'package:front/features/committee/data/committee_account.dart';
import 'package:front/features/committee/data/committee_retrieve_api_repository.dart';
import 'package:front/features/committee/data/committee_retrieve_api_response.dart';

class DummyCommitteeRetrieveProvider implements CommitteeRetrieveApiRepository{

  final CommitteeRetrieveApiResponse response;

  DummyCommitteeRetrieveProvider(this.response);

  @override
  Future<CommitteeRetrieveApiResponse> retrieve() async {
    return response;
  }
}

class DummyCommitteeRetrieveProviderFactory {

  final List<CommitteeAccount> sampleAccounts = [
    CommitteeAccount("국회운영위원회", "_description", 1, true, true, "_iconUrl"),
    CommitteeAccount("법제사법위원회", "_description", 2, true, true, "_iconUrl"),
    CommitteeAccount("정무위원회", "_description", 3, true, true, "_iconUrl"),
    CommitteeAccount("기회재정위원회", "_description", 4, true, true, "_iconUrl"),
    CommitteeAccount("교육위원회", "_description", 5, true, true, "_iconUrl"),
    CommitteeAccount("과학기술정보방송통신위원회", "_description", 6, true, true, "_iconUrl"),
    CommitteeAccount("외교통일위원회", "_description", 7, true, true, "_iconUrl"),
    CommitteeAccount("국방위원회", "_description", 8, true, true, "_iconUrl"),
    CommitteeAccount("행정안전위원회", "_description", 9, true, true, "_iconUrl"),
    CommitteeAccount("문화체육관광위원회", "_description", 10, true, true, "_iconUrl"),
    CommitteeAccount("농림축산해양수산위원회", "_description", 11, true, true, "_iconUrl"),
    CommitteeAccount("산업통상자원중소벤처기업위원회", "_description", 12, true, true, "_iconUrl"),
    CommitteeAccount("보건복지위원회", "_description", 13, true, true, "_iconUrl"),
    CommitteeAccount("환경노동위원회", "_description", 14, true, true, "_iconUrl"),
    CommitteeAccount("국토교통위원회", "_description", 15, true, true, "_iconUrl"),
    CommitteeAccount("정보위원회", "_description", 16, true, true, "_iconUrl"),
    CommitteeAccount("여성가족위원회", "_description", 17, true, true, "_iconUrl"),
    CommitteeAccount("예산결산특별위원회", "_description", 18, true, true, "_iconUrl"),
  ];

  DummyCommitteeRetrieveProvider withAllCommittee() {
    CommitteeRetrieveApiResponse response = CommitteeRetrieveApiResponse("title", "_subtitle", "_description", sampleAccounts);
    return DummyCommitteeRetrieveProvider(response);
  }

  DummyCommitteeRetrieveProvider withEmptyCommittee() {
    CommitteeRetrieveApiResponse response = CommitteeRetrieveApiResponse("title", "_subtitle", "_description", List.empty());
    return DummyCommitteeRetrieveProvider(response);
  }
}

