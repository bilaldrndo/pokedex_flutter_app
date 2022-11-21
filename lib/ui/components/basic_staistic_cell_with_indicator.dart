import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/helper_functions.dart';
import 'package:pokedex_app/utilities/theme.dart';

class BasicStatisticCellWithIndicator extends StatelessWidget {
  final Stats stat;

  const BasicStatisticCellWithIndicator({
    super.key,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GlobalTextWidget(
              parseName(stat.statName!),
              color: CustomTheme.darkGrayTitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(width: 8),
            GlobalTextWidget(
              stat.statValue!.toString(),
              color: CustomTheme.darkBlueTitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          barRadius: const Radius.circular(5),
          percent: stat.statValue!.toDouble() / 200,
          lineHeight: 4.0,
          center: Container(),
          progressColor: getBarLineColorBasedOnStatValue(stat.statValue!),
          animation: true,
          animationDuration: 1000,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
