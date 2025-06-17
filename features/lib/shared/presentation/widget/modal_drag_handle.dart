import 'package:design_system/theme/color_palette.dart';
import 'package:flutter/cupertino.dart';

class ModalDragHandle extends StatelessWidget {

  const ModalDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 30),
      decoration: const BoxDecoration(
          color: ColorPalette.greyDark,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: 3,
      width: 50,
    );
  }
}