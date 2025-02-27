import 'package:front/features/committee/data/committee_retrieve_api_response.dart';

abstract class CommitteeRetrieveApiRepository {

    Future<CommitteeRetrieveApiResponse> retrieve();
}
