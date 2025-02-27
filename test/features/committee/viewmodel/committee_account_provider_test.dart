import 'package:flutter_test/flutter_test.dart';
import 'package:front/features/committee/data/committee_retrieve_api_response.dart';
import 'package:front/features/committee/viewmodel/committee_account_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:front/features/committee/data/committee_retrieve_api_repository.dart';
import 'package:mockito/mockito.dart';

import 'committee_account_provider_test.mocks.dart';

@GenerateMocks([CommitteeRetrieveApiRepository])
void main() {
  testEmpty();
}

void testEmpty() {
  MockCommitteeRetrieveApiRepository mockRepository = MockCommitteeRetrieveApiRepository();
  setReturnEmpty(mockRepository);
  CommitteeAccountProvider provider = CommitteeAccountProvider(repository: mockRepository);
  provider.retrieve();
  test("emptystate인지 확인",
      ()=> {
        expect(provider.state, CommitteeAccountRetrieveState.empty)
      }
  );
}

dynamic setReturnEmpty(MockCommitteeRetrieveApiRepository mockRepository) {
  CommitteeRetrieveApiResponse emptyAccounts = CommitteeRetrieveApiResponse(
      "title",
      "subtitle",
      "description",
      List.empty()
  );
  when(mockRepository.retrieve())
      .thenAnswer((_) async => emptyAccounts);
}
