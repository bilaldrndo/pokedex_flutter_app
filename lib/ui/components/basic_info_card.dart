import 'package:flutter/material.dart';
import 'package:pokedex_app/models/basic_info_model.dart';
import 'package:pokedex_app/ui/components/basic_info_cell.dart';

class BasicInfoCard extends StatelessWidget {
  final List<BasicInfoModel> listOfStats;
  const BasicInfoCard({
    super.key,
    required this.listOfStats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 78,
      color: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        shrinkWrap: true,
        itemCount: listOfStats.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => BasicInfoCell(
          title: listOfStats[index].name!,
          value: listOfStats[index].value!,
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 48),
      ),
    );
  }
}
