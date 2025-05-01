import 'package:front/features/committee/domain/repositories/committee_bill_post_repository.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/domain/page.dart';

class DummyCommitteeBillPostThumbnailRepository implements CommitteeBillPostRepository {

  @override
  Future<List<BillThumbnail>> retrieve({required Committee committee, Page? page, List<BillPostTag>? tags}) async {
    Page currentPage = page ?? Page();
    int startIndexInclusive = currentPage.size * (currentPage.index - 1);
    int endIndexExclusive = startIndexInclusive + currentPage.size;
    if (startIndexInclusive >= _samples.length) {
      return [];
    }
    endIndexExclusive = endIndexExclusive.clamp(startIndexInclusive, _samples.length);
    print("GET : fetch committeeBillPostThumbnails with ${tags!.map((tag) => tag.value).toList()},,, pageIndex : ${currentPage.index}  sizd : ${currentPage.size},,,");
    await Future.delayed(const Duration(milliseconds: 500));
    return _samples.sublist(startIndexInclusive, endIndexExclusive);
  }
}


const List<BillThumbnail> _samples = [
  BillThumbnail(
    billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
    billName: "billName1",
    proposers: "이용우의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
    billName: "billName2",
    proposers: "이용우의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_G2G5F0D2E2C6D0L8L5K7I3J8H6I5D3",
    billName: "billName3",
    proposers: "김예지의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_R2P5X0Y2W2X6V0V8U5C9C2B8C7A4A7",
    billName: "billName4",
    proposers: "김예지의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_A2B5A0A2I0I6H1F1G0E4F2N8L8M1K9",
    billName: "6",
    proposers: "최보윤의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_H2F5G0E1M2M2L1M0K3K3J4J9R5P0Q9",
    billName: "7",
    proposers: "서삼석의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_L2K5K0S1S2R3S1Q6P0P8K5M2K6K6J6",
    billName: "주택법 일부개정법률안",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_U2V5T0T2B2A7A1Z5Z2Y4Y4U9U2T2R1",
    billName: "8",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_T2S5Q0Q1M1N3L1M4K4J7J0R0R5Q7R7",
    billName: "9",
    proposers: "이용선의원 등 12인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Y2G5F0D3E0C6K1L0K5I1J1H1D6E2C9",
    billName: "10",
    proposers: "오세희의원 등 11인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_X2X5V0W3V0V6T1U0C5A1B0Z9A3Y9Z3",
    billName: "11",
    proposers: "박지원의원 등 21인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_D2C5Y0Y2W2X0W1W6U2V3D2B0C4A5B3",
    billName: "12",
    proposers: "김동아의원 등 17인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_R2S5Q0R3P0N5O1J5L5J6J2H3I4G0O1",
    billName: "13",
    proposers: "김한규의원 등 12인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Z2A5Y0Z1G2H3G1E6E5C8D0Z9A0Y6W7",
    billName: "14",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_E2E5M0M2K0J4K1I6I3R5R4P4Q7O4N1",
    billName: "15",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Y2X5V0V2D2E6D1D1B3C5A4I6J3H8H2",
    billName: "16",
    proposers: "임호선의원 등 11인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_I2P4Q1O0N3M0U1S5R1S2R3N2L8K1J4",
    billName: "17",
    proposers: "박성민의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_V2U5U0C2C2B4C1A7A3Z8H4H5F7G9F4",
    billName: "18",
    proposers: "오세희의원 등 12인",
    legislativeBody: "철회",
  ),
  BillThumbnail(
    billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
    billName: "19",
    proposers: "이용우의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
    billName: "20",
    proposers: "이용우의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_G2G5F0D2E2C6D0L8L5K7I3J8H6I5D3",
    billName: "21",
    proposers: "김예지의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_R2P5X0Y2W2X6V0V8U5C9C2B8C7A4A7",
    billName: "22",
    proposers: "김예지의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_A2B5A0A2I0I6H1F1G0E4F2N8L8M1K9",
    billName: "23",
    proposers: "최보윤의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_H2F5G0E1M2M2L1M0K3K3J4J9R5P0Q9",
    billName: "24",
    proposers: "서삼석의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_L2K5K0S1S2R3S1Q6P0P8K5M2K6K6J6",
    billName: "25",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_U2V5T0T2B2A7A1Z5Z2Y4Y4U9U2T2R1",
    billName: "26",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_T2S5Q0Q1M1N3L1M4K4J7J0R0R5Q7R7",
    billName: "27",
    proposers: "이용선의원 등 12인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Y2G5F0D3E0C6K1L0K5I1J1H1D6E2C9",
    billName: "28",
    proposers: "오세희의원 등 11인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_X2X5V0W3V0V6T1U0C5A1B0Z9A3Y9Z3",
    billName: "29",
    proposers: "박지원의원 등 21인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_D2C5Y0Y2W2X0W1W6U2V3D2B0C4A5B3",
    billName: "30",
    proposers: "김동아의원 등 17인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_R2S5Q0R3P0N5O1J5L5J6J2H3I4G0O1",
    billName: "31",
    proposers: "김한규의원 등 12인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Z2A5Y0Z1G2H3G1E6E5C8D0Z9A0Y6W7",
    billName: "32",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_E2E5M0M2K0J4K1I6I3R5R4P4Q7O4N1",
    billName: "33",
    proposers: "박덕흠의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Y2X5V0V2D2E6D1D1B3C5A4I6J3H8H2",
    billName: "34",
    proposers: "임호선의원 등 11인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_I2P4Q1O0N3M0U1S5R1S2R3N2L8K1J4",
    billName: "35",
    proposers: "박성민의원 등 10인",
    legislativeBody: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_V2U5U0C2C2B4C1A7A3Z8H4H5F7G9F4",
    billName: "36",
    proposers: "오세희의원 등 12인",
    legislativeBody: "철회",
  ),
];