import 'package:front/features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:front/features/pre_announce/domain/repositories/preannounce_bill_detail_respository.dart';
import 'package:front/features/shared/domain/bil_detail.dart';

class DummyPreAnnounceBillDetailRepository implements PreAnnounceBillDetailRepository  {

  @override
  Future<PreAnnounceBillDetail> retrieve({required String billId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _sample;
  }
}


final PreAnnounceBillDetail _sample = PreAnnounceBillDetail(
    title: "지방세법 일부개정법률안",
    proposerSummary: "김예지의원 등 10인",
    legislativeBody: "legislativebody",
    preAnnouncementSection: PreAnnouncementSection(
        deadline: DateTime.now(),
        dDAy: 1,
        linkUrl: "smaple.url.com"
    ),
    detail: """
제안이유 및 주요내용

  현행법은 재산세의 과세기준일인 6월 1일을 기준으로 재산을 소유하고 있는 자에 대하여 재산세 납세의무를 부과하고 있음.
  그러나 매매ㆍ증여 등으로 재산의 소유권이 변동되는 경우에도 6월 1일을 기준으로 재산을 소유하고 있는 자가 재산의 소유기간과 무관하게 해당 연도분의 재산세를 모두 납부해야 하는 실정인데, 이는 세 부담의 형평성을 크게 저해한다는 지적이 있음.
  이를 개선하기 위해서는 소유기간에 따라 재산세를 일할계산하여 부과ㆍ징수하는 방안을 고려할 수 있으나, 이 경우 과도한 조세징수비용으로 조세행정의 효율성이 크게 떨어지는 문제점이 있음.
  이에 매년 6월 1일과 12월 1일을 기준으로 1년에 2회 재산세를 부과ㆍ납부하도록 함으로써 조세 부담의 형평성과 조세행정의 효율성을 함께 도모하려는 것임(안 제111조, 제112조, 제114조, 제115조 및 제122조).

참고사항

  이 법률안은 김예지의원이 대표발의한 「종합부동산세법 일부개정법률안」(의안번호 제8698호)의 의결을 전제로 하는 것이므로 같은 법률안이 의결되지 아니하거나 수정의결되는 경우에는 이에 맞추어 조정하여야 할 것임.""",
    proposerSection: BillProposerSection(
        billProposerRate: BillProposerRate.fromPartyName({"국민의힘" : 10}),
        billProposers: [
          BillProposer(name: "고동진", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "김선교", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "김소희", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "김예지", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "김형동", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "서명옥", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "서천호", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "송석준", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "조경태", profileImage: "", partyName: "국민의힘"),
          BillProposer(name: "최수진", profileImage: "", partyName: "국민의힘"),
        ]
    ),
    summarySection: null
);
