import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortingVisualizer extends StatelessWidget {
  final RxList<int> pillars;

  const SortingVisualizer({Key? key, required this.pillars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pillars.map((height) {
          return Container(
            width: 20,
            height: height.toDouble(),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.blue,
          );
        }).toList(),
      );
    });
  }
}
