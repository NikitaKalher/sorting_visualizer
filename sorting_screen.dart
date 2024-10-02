import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sorting_controller.dart';
import 'sorting_visualizer.dart';

class SortingScreen extends StatelessWidget {
  final String title;
  final String description;
  final Function(SortingController) sortingAlgorithm;

  const SortingScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.sortingAlgorithm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SortingController controller = Get.put(SortingController());

    // Initialize 8 pillars on loading
    controller.initializePillars(8);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Card(
                elevation: 10,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SortingVisualizer(pillars: controller.pillars),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      sortingAlgorithm(controller); // Starts the sorting algorithm
                      controller.startSorting(); // Start sorting
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const SizedBox.shrink(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: controller.restartSorting, // Restart button
                    icon: const Icon(Icons.refresh),
                    label: const SizedBox.shrink(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Obx(() => ElevatedButton.icon(
                    onPressed: controller.togglePause, // Pause/Resume button
                    icon: Icon(
                      controller.isPaused.value ? Icons.play_arrow : Icons.pause,
                    ),
                    label: const SizedBox.shrink(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Obx(() => Text(
                    'Speed: ${controller.speed.value.toStringAsFixed(2)}x',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Obx(() => Slider(
                    value: controller.speed.value,
                    min: 0.1,
                    max: 5.0,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white54,
                    onChanged: (value) {
                      controller.speed.value = value; // Update speed
                    },
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16), // Adding space at the bottom
          ],
        ),
      ),
    );
  }
}
