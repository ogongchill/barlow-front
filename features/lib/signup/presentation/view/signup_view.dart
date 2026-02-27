import 'package:features/signup/presentation/widget/login_button_widget.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  final String nickname;

  const SignupView({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return LoginButtonWidget(nickname: nickname);
  }
}
