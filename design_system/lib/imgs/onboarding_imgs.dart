enum OnboardingImages {

  page1('packages/design_system/assets/onboarding/onboarding_page_1.png'),
  page2('packages/design_system/assets/onboarding/onboarding_page_2.png'),
  page3('packages/design_system/assets/onboarding/onboarding_page_3.png'),
  ;

  final String _path;

  const OnboardingImages(this._path);

  String get path => _path;
}