
import 'dart:math';

import 'package:front/features/home/domain/entities/committee_account.dart';
import 'package:front/features/home/domain/repositories/committee_account_repository.dart';

class DummyCommitteeAccountRepository implements SubscribeCommitteeInfoRepository{

  final List<SubscribeCommitteeInfo> response;
  final int delaySecond;
  final bool throwException;

  DummyCommitteeAccountRepository(this.response, this.delaySecond, this.throwException);

  @override
  Future<List<SubscribeCommitteeInfo>> retrieveSubscribedCommittee() async {
    await Future.delayed(Duration(seconds: delaySecond));
    if(throwException) {
      throw Exception("exception occurs by dev ");
    }
    return response;
  }
}

class RandomCommitteeAccountRepository implements SubscribeCommitteeInfoRepository{

  final Random random = Random();

  @override
  Future<List<SubscribeCommitteeInfo>> retrieveSubscribedCommittee() async {
    int delayTime = random.nextInt(2000) + 1000;
    await Future.delayed(Duration(milliseconds: delayTime));
    List<SubscribeCommitteeInfo> items = List.from(DummyCommitteeAccountRepositoryFactory.sampleAccounts);
    items.shuffle(random);
    int randomCount = random.nextInt(18);
    return items.take(randomCount).toList();
  }
}

class DummyCommitteeAccountRepositoryFactory {

  static final List<SubscribeCommitteeInfo> sampleAccounts = [
    SubscribeCommitteeInfo("국회운영위원회", "_description", 1, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("법제사법위원회", "_description", 2, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("정무위원회", "_description", 3, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("기획재정위원회", "_description", 4, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("교육위원회", "_description", 5, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("과학기술정보방송통신위원회", "_description", 6, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("외교통일위원회", "_description", 7, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("국방위원회", "_description", 8, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("행정안전위원회", "_description", 9, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("문화체육관광위원회", "_description", 10, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("농림축산식품해양수산위원회", "_description", 11, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("산업통상자원중소벤처기업위원회", "_description", 12, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("보건복지위원회", "_description", 13, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("환경노동위원회", "_description", 14, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("국토교통위원회", "_description", 15, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("정보위원회", "_description", 16, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("여성가족위원회", "_description", 17, true, true, "_iconUrl"),
    SubscribeCommitteeInfo("예산결산특별위원회", "_description", 18, true, true, "_iconUrl"),
  ];

  static DummyCommitteeAccountRepository withAllCommittee() {
    return DummyCommitteeAccountRepository(sampleAccounts, 2, false);
  }

  static DummyCommitteeAccountRepository withEmptyCommittee() {
    return DummyCommitteeAccountRepository(List.empty(), 2, false);
  }

  static DummyCommitteeAccountRepository withError() {
    return DummyCommitteeAccountRepository(List.empty(), 2, true);
  }

  static DummyCommitteeAccountRepository withFromTopFive() {
    return DummyCommitteeAccountRepository(sampleAccounts.sublist(0,4), 2, false);
  }

  static RandomCommitteeAccountRepository withRandom() {
    return RandomCommitteeAccountRepository();
  }
}

