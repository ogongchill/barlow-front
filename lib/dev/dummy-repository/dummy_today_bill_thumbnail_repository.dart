import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/home/domain/repositories/today_bill_thumbnail_repository.dart';

class DummyTodayBillThumbnailRepository implements TodayBillThumbnailRepository {

  final List<BillThumbnail> _thumbnails;
  final bool throwFlag;

  DummyTodayBillThumbnailRepository(this._thumbnails, this.throwFlag);

  @override
  Future<List<BillThumbnail>> retrieveTodayBillThumbnails() async {
    if(throwFlag) {
      throw Exception("exception occurs by dev");
    }
    await Future.delayed(const Duration(seconds: 2));
    return _thumbnails;
  }
}

class DummyTodayBillThumbnailRepositoryFactory {

  static DummyTodayBillThumbnailRepository withAllSamples() {
    return DummyTodayBillThumbnailRepository(samples, false);
  }

  static DummyTodayBillThumbnailRepository withEmpty() {
    return DummyTodayBillThumbnailRepository([], false);
  }

  static DummyTodayBillThumbnailRepository withError() {
    return DummyTodayBillThumbnailRepository([], true);
  }
}

final List<BillThumbnail> samples = [
  BillThumbnail(
    billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
    billName: "산업안전보건법 일부개정법률안",
    proposers: "이용우의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
    billName: "법원조직법 일부개정법률안",
    proposers: "이용우의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_G2G5F0D2E2C6D0L8L5K7I3J8H6I5D3",
    billName: "지방세법 일부개정법률안",
    proposers: "김예지의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_R2P5X0Y2W2X6V0V8U5C9C2B8C7A4A7",
    billName: "종합부동산세법 일부개정법률안",
    proposers: "김예지의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_A2B5A0A2I0I6H1F1G0E4F2N8L8M1K9",
    billName: "사회복지공동모금회법 일부개정법률안",
    proposers: "최보윤의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_H2F5G0E1M2M2L1M0K3K3J4J9R5P0Q9",
    billName: "기업도시개발 특별법 일부개정법률안",
    proposers: "서삼석의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_L2K5K0S1S2R3S1Q6P0P8K5M2K6K6J6",
    billName: "주택법 일부개정법률안",
    proposers: "박덕흠의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_U2V5T0T2B2A7A1Z5Z2Y4Y4U9U2T2R1",
    billName: "체육시설의 설치·이용에 관한 법률 일부개정법률안",
    proposers: "박덕흠의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_T2S5Q0Q1M1N3L1M4K4J7J0R0R5Q7R7",
    billName: "국가재정법 일부개정법률안",
    proposers: "이용선의원 등 12인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Y2G5F0D3E0C6K1L0K5I1J1H1D6E2C9",
    billName: "전자금융거래법 일부개정법률안",
    proposers: "오세희의원 등 11인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_X2X5V0W3V0V6T1U0C5A1B0Z9A3Y9Z3",
    billName: "국가인권위원회법 일부개정법률안",
    proposers: "박지원의원 등 21인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_D2C5Y0Y2W2X0W1W6U2V3D2B0C4A5B3",
    billName: "발명진흥법 일부개정법률안",
    proposers: "김동아의원 등 17인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_R2S5Q0R3P0N5O1J5L5J6J2H3I4G0O1",
    billName: "대·중소기업 상생협력 촉진에 관한 법률 일부개정법률안",
    proposers: "김한규의원 등 12인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Z2A5Y0Z1G2H3G1E6E5C8D0Z9A0Y6W7",
    billName: "국민체육진흥법 일부개정법률안",
    proposers: "박덕흠의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_E2E5M0M2K0J4K1I6I3R5R4P4Q7O4N1",
    billName: "사회복지사업법 일부개정법률안",
    proposers: "박덕흠의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_Y2X5V0V2D2E6D1D1B3C5A4I6J3H8H2",
    billName: "도로교통법 일부개정법률안",
    proposers: "임호선의원 등 11인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_I2P4Q1O0N3M0U1S5R1S2R3N2L8K1J4",
    billName: "소상공인 생계형 적합업종 지정에 관한 특별법 일부개정법률안",
    proposers: "박성민의원 등 10인",
    legislationProcess: "계류의안",
  ),
  BillThumbnail(
    billId: "PRC_V2U5U0C2C2B4C1A7A3Z8H4H5F7G9F4",
    billName: "전자금융거래법 일부개정법률안",
    proposers: "오세희의원 등 12인",
    legislationProcess: "철회",
  ),
];