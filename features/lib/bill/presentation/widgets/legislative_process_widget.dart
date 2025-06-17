import 'package:design_system/theme/color_palette.dart';
import 'package:features/bill/domain/constant/legislative_process.dart';
import 'package:flutter/cupertino.dart';

class LegislativeProcessWidget extends StatelessWidget {

  static const TextStyle _unselectedStyle = TextStyle(
    fontFamily: "gmarketSans",
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: ColorPalette.borderBlack,
    height: 1.1
  );

  static const TextStyle _selectedStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 9,
      fontWeight: FontWeight.w500,
      color: ColorPalette.bluePrimary,
      height: 1.1
  );

  static const TextStyle _unselectedOrderStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: ColorPalette.borderBlack
  );

  static const TextStyle _selectedOrderStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: ColorPalette.innerContent
  );

  final LegislativeProcess legislativeProcess;

  const LegislativeProcessWidget({super.key, required this.legislativeProcess});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
        LegislativeProcess.values
            .map((process) => _buildProcessWidget(process.order, process.name, process == legislativeProcess))
            .toList()
    );
  }

  Widget _buildProcessWidget(int number, String text, bool isSelected) {
    Color color = isSelected ? ColorPalette.bluePrimary : ColorPalette.greyLight;
    TextStyle textStyle = isSelected ? _selectedStyle : _unselectedStyle;
    TextStyle orderStyle = isSelected ? _selectedOrderStyle : _unselectedOrderStyle;
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: ColorPalette.innerContent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: color,
            width: 1.0
        )
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color
              ),
              child: Align(
                alignment:Alignment.center,
                child: Text("$number", style: orderStyle, textAlign: TextAlign.center,)) ,
            ),
          ),
         Expanded(
             child: Container(
                 alignment: Alignment.center,
                 child: Text(
                   text,
                   style: textStyle,
                   textAlign: TextAlign.center,
                 )
             )
          ),
        ],
      ),
    );
  }
}