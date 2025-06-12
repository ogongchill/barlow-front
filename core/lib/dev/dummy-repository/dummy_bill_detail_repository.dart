import 'package:features/bill_info/domain/entities/bill_detail.dart';
import 'package:features/bill_info/domain/repositories/bill_repository.dart';
import 'package:features/shared/domain/bil_detail.dart';

class DummyBillDetailRepository implements BillDetailRepository {

  final Map<String, BillDetail>_billDetailMap;

  DummyBillDetailRepository({required Map<String, BillDetail> billDetailMap})
  : _billDetailMap = billDetailMap;

  @override
  Future<BillDetail> getBillDetail(String billId) async {
    await Future.delayed(Duration(seconds: 2));
    if(!_billDetailMap.containsKey(billId)) {
      throw Exception("no such bill id : $billId");
    }
    return _billDetailMap[billId]!;
  }
}

class DummyBillDetailErrorRepository implements BillDetailRepository {

  @override
  Future<BillDetail> getBillDetail(String billId) async {
    await Future.delayed(Duration(seconds: 2));
    throw Exception("exception caused by dev");
  }
}

class DummyBillDetailRepositoryFactory {

  static final Map<String, BillDetail> _samples = {
    "PRC_G2G5F0D2E2C6D0L8L5K7I3J8H6I5D3"
        : BillDetail(
        title: "지방세법 일부개정법률안",
        proposerSummary: "김예지의원 등 10인",
        proposerType: "의원",
        legislativeBody: "소관위 미접수",
        createdAt: DateTime(2025,3,6,0,0,0,0),
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
    ),
    "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5" :
        BillDetail(
            title: "산업안전보건법 일부개정법률안",
            proposerSummary: "이용우의원 등 10인",
            proposerType: "의원",
            legislativeBody: "상임위원회 미접수",
            createdAt: DateTime(2025,3,6),
            detail: """
제안이유
            
  한국산업안전보건공단은 산업재해 발생 시 고용노동부훈령(행정규칙)인 「근로감독관 집무규정(산업안전보건)」 및 한국산업안전보건공단 내규인 「재해 등의 기술적 원인조사 업무처리지침」에 따라 ‘재해조사의견서’(2024년 9월 ‘재해원인조사의견서’로 명칭 변경)를 작성하고 있으나, 법령상 명시적인 작성 근거는 부족한 상태임.
  한편, 고용노동부는 2022년 11월 「중대재해 감축 로드맵」을 발표하고, 그 세부내용으로 ‘재해조사의견서 공개’를 포함하였으나, 그 후 고용노동부는 2023년 1월 “수사기관의 공정한 수사에 어려움을 겪을 가능성이 상당하다”며 검찰 기소 이후에만 공개해야 한다는 취지의 보도설명자료를 재차 배포하였음.
  그러나 법원은 최근 고용노동부 서울강남지청과 서울중앙지방검찰청을 상대로 사건 조사보고서, 내사보고서 및 수사결과보고서, 피의자신문조서 등 각종 수사자료를 공개하라는 취지로 제기된 정보공개거부처분 취소소송에서, “통상적으로 알려진 수사의 방법이나 절차를 넘어 일반에게 공개될 경우 향후 범죄의 예방이나 정보수집, 수사활동 등에 영향을 미쳐 수사기관의 직무수행을 현저히 곤란하게 할 만한 내용이 포함되어 있지는 않으므로, 이 사건 정보가 「정보공개법」 제9조제1항제4호의 비공개대상에 해당한다고 할 수 없다”라는 이유로 원고(민원인) 승소 결정하여 해당 수사자료들을 공개하도록 하였고(서울행정법원 2023.3.17. 선고 2022구합61069), 고용노동부도 이에 대해 “법원의 판결에 반박할 추가 증거자료가 없고, 법원의 판결로 정보공개 시 지청이 부담할 수 없는 법적 분쟁 위험이 해소되어 항소 포기 및 법무부에 항소포기 지휘 건의”하여 해당 판결이 확정되었다는 내용을 국회에 제출하였음.
  아울러 현행 「항공ㆍ철도 사고조사에 관한 법률」과 「해양사고의 조사 및 심판에 관한 법률」은 행정기관인 조사위원회가 작성한 사고조사보고서를 국민에게 공표하도록 하고 있으며, 사고조사는 사법절차 등과 분리하여 독립적으로 수행되는 것이라는 취지도 명시하고 있음.
  특히 중대재해 발생 시 오로지 “수사 중”이라는 이유로 각종 사고 관련 자료가 비공개되어 재해자와 가족의 알 권리가 장기간 침해되고, 이에 따라 배상ㆍ보상을 위한 민사상 손해배상청구도 수사 종결 전까지 사실상 불가하여 상당한 불이익을 겪고 있는 현실을 감안하면, 중대재해 원인에 관한 재해조사의견서와 고용노동부의 수사결과보고서를 조기에 공개하거나 최소한 재해자 및 가족에게 교부하여 실효적 구조가 가능하도록 할 필요가 있음.
  이에 “통상적으로 알려진 수사의 방법 등을 넘지 않는 내용은 「정보공개법」 제9조제1항제4호의 비공개대상에 해당하지 않는다”는 법원의 결정 취지와, 이에 대한 고용노동부의 수용의견, 「항공ㆍ철도 사고조사에 관한 법률」 및 「해양사고의 조사 및 심판에 관한 법률」 입법례 등을 종합적으로 고려하여 중대재해에 대한 재해조사의견서와 수사결과보고서를 법률에 따라 공개 또는 교부하도록 하려는 것임.

주요내용

가. 현재 한국산업안전보건공단이 중대재해 발생 시 고용노동부 행정규칙(집무규정)에 의하여 작성하는 문서인 ‘재해조사의견서’의 법률상 작성근거를 마련하고, 작성의무를 부과함(안 제56조의2제1항).
나. 중대재해 발생 시 한국산업안전보건공단으로 하여금 고용노동부장관이 실시하는 원인조사에 반드시 참여하도록 하고, 조사에 필요한 권한 등을 정비함(안 제56조, 제162조, 제162조의2 등).
다. 고용노동부장관은 1) 재해자와 유가족 등의 알 권리 및 실효적 권리구제와 2) 동종ㆍ유사재해 방지를 목적으로 중대재해 발생 6개월 내에 공단이 작성한 재해조사의견서를 공개하되, 유가족 등이 교부를 청구하는 경우에는 발생 3개월 내에 교부하도록 함(안 제56조의2제2항 등).
라. 고용노동부장관은 1) 재해자와 유가족 등의 알 권리 및 실효적 권리구제와 2) 동종ㆍ유사재해 방지를 목적으로 검사의 공소제기 이후 중대재해사건의 수사결과보고서를 공개할 수 있도록 하되, 재해자 또는 그 가족 등이 교부를 청구하는 경우에는 공소제기 이후에 반드시 교부하도록 함(안 제56조의3제1항 등).
마. 이 법 시행일 전에 작성된 재해조사의견서(재해원인조사의견서) 및 수사결과보고서에 관해서도 고용노동부장관의 공개 또는 교부의무를 규정함(부칙 제3조부터 제5조까지).
            """,
            summarySection: null,
            proposerSection: BillProposerSection(
              billProposerRate: BillProposerRate.fromPartyName(
                   {
                    "더불어민주당" : 9,
                    "진보당" : 1
                  }
              ),
              billProposers: [
                BillProposer(name: "김우영", profileImage: "profileImage", partyName: "더불어민주당"),
                BillProposer(name: "김태선", profileImage: "profileImage", partyName: "국민의힘"),
                BillProposer(name: "박용갑", profileImage: "profileImage", partyName: "조국혁신당"),
                BillProposer(name: "박홍배", profileImage: "profileImage", partyName: "무소속"),
                BillProposer(name: "이용우", profileImage: "profileImage", partyName: "개혁신당"),
                BillProposer(name: "이학영", profileImage: "profileImage", partyName: "사회민주당"),
                BillProposer(name: "임미애", profileImage: "profileImage", partyName: "기본소득당"),
                BillProposer(name: "장철민", profileImage: "profileImage", partyName: "더불어민주당"),
                BillProposer(name: "전진숙", profileImage: "profileImage", partyName: "더불어민주당"),
                BillProposer(name: "정혜경", profileImage: "profileImage", partyName: "진보당"),
              ]
            )
        )
  };

  static BillDetailRepository withSamples() {
    return DummyBillDetailRepository(billDetailMap: _samples);
  }

  static BillDetailRepository withError() {
    return DummyBillDetailErrorRepository();
  }
}

