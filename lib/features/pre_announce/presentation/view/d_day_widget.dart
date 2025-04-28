import 'package:flutter/cupertino.dart';
import 'package:front/core/theme/color_palette.dart';

class DdayWidget extends StatelessWidget {

  static const TextStyle _style = TextStyle(
      color: ColorPalette.innerContent,
      fontSize: 10,
      fontWeight: FontWeight.w800,
      fontFamily: "gmarketSans",
  );

  final _Dday _dDay;

  DdayWidget({super.key, required int dDay})
  : _dDay = _DdayFactory.dDayOf(dDay);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: _dDay.color,
        shape: BoxShape.circle
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          child: Text(_dDay.context, style: _style, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

class _DdayFactory {
  static _Dday dDayOf(int dDay) {
    if(dDay < 0) {
      return _Dday(context: "마감됨", color: ColorPalette.greyDark);
    }
    if(dDay == 0) {
      return _Dday(context: "오늘\n마감", color: ColorPalette.orangeDeep);
    }
    if(dDay < 4) {
      return _Dday(context: "D-$dDay", color: ColorPalette.orangePrimary);
    }
    return _Dday(context: "D-$dDay", color: ColorPalette.orangeLight);
  }
}

class _Dday {

  final String context;
  final Color color;

  _Dday({required this.context, required this.color});
}