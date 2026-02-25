enum OidcProvider {
  kakao;

  String get apiValue {
    switch (this) {
      case OidcProvider.kakao:
        return 'KAKAO';
    }
  }
}

class TermAgreementItem {
  final int id;
  final String title;
  final String linkUrl;
  final bool isRequired;
  final bool isAgreed;

  const TermAgreementItem({
    required this.id,
    required this.title,
    required this.linkUrl,
    required this.isRequired,
    required this.isAgreed,
  });

  TermAgreementItem copyWith({bool? isAgreed}) {
    return TermAgreementItem(
      id: id,
      title: title,
      linkUrl: linkUrl,
      isRequired: isRequired,
      isAgreed: isAgreed ?? this.isAgreed,
    );
  }
}

class OidcSignupInfo {
  final String idToken;
  final OidcProvider provider;
  final List<TermAgreementItem> termAgreements;
  final String nickname;
  final String deviceId;
  final String deviceToken;
  final String deviceOs;

  const OidcSignupInfo({
    required this.idToken,
    required this.provider,
    required this.termAgreements,
    required this.nickname,
    required this.deviceId,
    required this.deviceToken,
    required this.deviceOs,
  });
}
