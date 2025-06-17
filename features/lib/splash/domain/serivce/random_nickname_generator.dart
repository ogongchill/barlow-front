import 'dart:math';

class RandomNicknameGenerator {

  static const List<String> adjectives = [
    '건조한',
    '눈부신',
    '음흉한',
    '거대한',
    '차가운',
    '심심한',
    '지루한',
    '어설픈',
    '완벽한',
    '단단한',
    '빠른',
    '느긋한',
    '알수없는',
    '뾰족한',
    '고장난',
    '튼튼한',
    '휴대용',
    '반짝이는',
    '침수된',
    '밀폐된',
    '바삭한',
    '빛나는',
    '어려운',
    '화사한',
    '작은',
    '배고픈',
  ];
  static const List<String> nouns = [
    '시민',
    '친구',
    '유권자',
    '감시자',
    '소시민',
    '구경꾼',
    '동료',
    '이웃',
    '관람객',
    '참여자',
    '행인',
    '일반인',
    '사용자',
    '신사',
    '전문가',
    '당원',
  ];
  static final Random _random = Random();
  static final RandomNicknameGenerator instance = RandomNicknameGenerator._();

  RandomNicknameGenerator._();

  String getRandom() {
    String adjective = adjectives[_random.nextInt(adjectives.length)];
    String noun = nouns[_random.nextInt(nouns.length)];
    return '${adjective}_$noun';
  }
}