import 'dart:async';

import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/shared/domain/party.dart';
import 'package:flutter/material.dart';

class SingleBarChart extends StatefulWidget {
  final Map<Party, int> data;

  const SingleBarChart({super.key, required this.data});

  @override
  _SingleBarChartState createState() => _SingleBarChartState();
}

class _SingleBarChartState extends State<SingleBarChart> {
  Party? selectedParty;
  double? tapX;
  Timer? _hideIconTimer;

  final GlobalKey _barKey = GlobalKey(); // ✅ 전체 바 차트 위치 추적

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    int totalValue = widget.data.values.fold(0, (sum, value) => sum + value);
    double chartHeight = 40;
    double chartWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                key: _barKey, // ✅ 바 차트 전체에 대한 키 설정
                child: Row(
                  children: widget.data.entries.map((entry) {
                    double percentage = totalValue > 0 ? (entry.value / totalValue) : 0;
                    return Flexible(
                      flex: (percentage * 100).toInt(),
                      child: GestureDetector(
                        onTapDown: (details) {
                          _hideIconTimer?.cancel();

                          // ✅ 바 차트 전체 기준 좌표 변환
                          RenderBox barBox = _barKey.currentContext?.findRenderObject() as RenderBox;
                          Offset barOffset = barBox.localToGlobal(Offset.zero);

                          double globalX = details.globalPosition.dx; // ✅ 화면 기준 좌표
                          double relativeX = globalX - barOffset.dx; // ✅ 바 차트 기준 X 좌표

                          setState(() {
                            selectedParty = entry.key; // ✅ 선택한 Party 저장
                            tapX = relativeX; // ✅ 변환된 X 좌표 저장
                          });

                          _hideIconTimer = Timer(const Duration(seconds: 2), () {
                            if (mounted) {
                              setState(() {
                                selectedParty = null;
                                tapX = null;
                              });
                            }
                          });
                        },
                        child: Container(
                          height: chartHeight,
                          color: entry.key.color,
                          alignment: Alignment.center,
                          child: percentage > 0.05
                              ? Text("${entry.value} 명", style: TextStylePreset.barInnerText)
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // ✅ 데이터 범례 (각 요소의 색상과 이름)
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                children: widget.data.keys.map((party) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        color: party.color,
                      ),
                      const SizedBox(width: 5),
                      Text(party.name, style: TextStylePreset.innerContentLight),
                    ],
                  );
                }).toList(),)
            ],
          ),

          // ✅ 아이콘을 터치한 Party 위에 정확히 표시
          if (selectedParty != null && tapX != null)
            Positioned(
              left: tapX!.clamp(0, chartWidth - 40) - 20, // ✅ 전체 바 차트 기준으로 x 좌표 계산
              top: -50, // ✅ 막대 위로 고정
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: selectedParty!.svgPicture, // ✅ 선택한 Party의 아이콘 표시
              ),
            ),
        ],
      )
    );
  }
}



