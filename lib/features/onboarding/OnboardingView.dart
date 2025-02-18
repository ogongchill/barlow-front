import 'package:flutter/material.dart';
import 'package:front/features/committee/screen/CommitteeView.dart';
import 'OnboardingContent.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Our App",
      "description": "Discover new features and enjoy the experience.",
      "image": "https://via.placeholder.com/300"
    },
    {
      "title": "Stay Connected",
      "description": "Stay in touch with your friends and family.",
      "image": "https://via.placeholder.com/300"
    },
    {
      "title": "Get Started",
      "description": "Sign up now to explore more.",
      "image": "https://via.placeholder.com/300"
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => OnboardingContent(
              title: onboardingData[index]['title']!,
              description: onboardingData[index]['description']!,
              image: onboardingData[index]['image']!,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    onboardingData.length,
                        (index) => buildDot(index: index),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      // 온보딩이 끝나면 MainPage로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const CommitteeView()),
                      );                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == onboardingData.length - 1 ? 'Start' : 'Next',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
