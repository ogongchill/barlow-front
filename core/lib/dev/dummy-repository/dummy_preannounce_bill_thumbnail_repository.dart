import 'package:features/pre_announce/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:features/pre_announce/domain/repositories/preannounce_bill_thumbnail_repository.dart';
import 'package:features/pre_announce/domain/repositories/sort_key.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/page.dart';

class DummyPreAnnounceBillThumbnailRepository implements PreAnnounceBillThumbnailRepository {

  @override
  Future<List<PreAnnounceBillThumbnail>> retrieve({Page? page, List<BillPostTag>? tags, PreAnnounceBillPostSortKey? sortKey}) async {
    Page currentPage = page ?? Page();
    int startIndexInclusive = currentPage.size * (currentPage.index - 1);
    int endIndexExclusive = startIndexInclusive + currentPage.size;
    if (startIndexInclusive >= _samples.length) {
      return [];
    }
    endIndexExclusive = endIndexExclusive.clamp(startIndexInclusive, _samples.length);
    print("GET : fetch recentBillThumbnails with ${tags!.map((tag) => tag.value).toList()},,, sort : ${sortKey!.isAscending} pageIndex : ${currentPage.index}  size : ${currentPage.size},,,");
    await Future.delayed(const Duration(milliseconds: 500));
    return _samples.sublist(startIndexInclusive, endIndexExclusive);
  }
}


final List<PreAnnounceBillThumbnail> _samples = [
  PreAnnounceBillThumbnail(
    billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
    billName: "산업안전보건법 일부개정법률안인데 엄청 긴 제목을 위해서 늘려봄",
    proposers: "이용우의원 등 10인",
    legislativeBody: "계류의안",
    dDay: 0
  ),
  PreAnnounceBillThumbnail(
    billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
    billName: "법원조직법 일부개정법률안",
    proposers: "이용우의원 등 10인",
    legislativeBody: "계류의안",
    dDay: 1
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 2
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 3
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 4
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 5
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 6
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 7
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 0
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 1
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 2
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 3
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 4
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 5
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 6
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 7
  ),  PreAnnounceBillThumbnail(
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      billName: "산업안전보건법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 8
  ),
  PreAnnounceBillThumbnail(
      billId: "PRC_F2F5E0E2M2N5L0M9K2I4J3F8F0D9E9",
      billName: "법원조직법 일부개정법률안",
      proposers: "이용우의원 등 10인",
      legislativeBody: "계류의안",
      dDay: 9
  ),
];