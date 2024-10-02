import 'package:get/get.dart';
import 'dart:math';

class SortingController extends GetxController {
  // Observable list of pillars (heights of the pillars)
  var pillars = <int>[].obs; // Changed to RxList

  // Observable speed value
  RxDouble speed = 1.0.obs;

  // Observable bool to check if sorting is paused
  RxBool isPaused = false.obs;

  // Method to initialize the pillars with a given count
  void initializePillars(int count) {
    // Generate unsorted pillars
    pillars.value = generateRandomPillars(count);
  }

  // Method to generate a list of random pillar heights for visualization
  List<int> generateRandomPillars(int size) {
    Random random = Random();
    return List<int>.generate(size, (index) => random.nextInt(300) + 50); // Random heights between 50 and 350
  }

  // Function to clear pillars
  void clearPillars() {
    pillars.clear();
  }

  // Restart sorting with random pillars
  void restartSorting() {
    pillars.value = generateRandomPillars(pillars.length); // Generates random pillars
  }

  // Method to add delay according to the selected speed
  Future<void> wait() async {
    await Future.delayed(Duration(milliseconds: (1000 ~/ speed.value).toInt()));
  }

  // Method to check if sorting is paused
  Future<void> checkPause() async {
    while (isPaused.value) {
      await Future.delayed(Duration(milliseconds: 100)); // Wait until resumed
    }
  }

  // Method to start sorting
  Future<void> startSorting() async {
    for (int i = 0; i < pillars.length; i++) {
      await checkPause(); // Check if paused before proceeding
      // Sorting logic here (e.g., bubble sort, selection sort, etc.)
      for (int j = 0; j < pillars.length - i - 1; j++) {
        await wait(); // Wait for the speed duration
        if (pillars[j] > pillars[j + 1]) {
          // Swap the elements
          int temp = pillars[j];
          pillars[j] = pillars[j + 1];
          pillars[j + 1] = temp;
        }
      }
    }
  }

  // Toggle pause/resume
  void togglePause() {
    isPaused.value = !isPaused.value;
  }
}
