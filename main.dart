import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sorting_screen.dart';
import 'sorting_algorithms.dart';
import 'splash_screen.dart'; // Import your splash screen

void main() {
  runApp(const SortingVisualizerApp());
}

class SortingVisualizerApp extends StatelessWidget {
  const SortingVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set initial route to splash screen
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()), // Splash screen route
        GetPage(name: '/home', page: () => const SortingHomePage()), // Home page route
        GetPage(
          name: '/insertionSort',
          page: () => const SortingScreen(
            title: 'Insertion Sort',
            description: 'Insertion Sort works by picking elements one by one...',
            sortingAlgorithm: insertionSortAlgorithm,
          ),
        ),
        GetPage(
          name: '/selectionSort',
          page: () => const SortingScreen(
            title: 'Selection Sort',
            description: 'Selection Sort works by repeatedly finding...',
            sortingAlgorithm: selectionSortAlgorithm,
          ),
        ),
        GetPage(
          name: '/bubbleSort',
          page: () => const SortingScreen(
            title: 'Bubble Sort',
            description: 'Bubble Sort works by repeatedly swapping...',
            sortingAlgorithm: bubbleSortAlgorithm,
          ),
        ),
        GetPage(
          name: '/mergeSort',
          page: () => const SortingScreen(
            title: 'Merge Sort',
            description: 'Merge Sort works by dividing the array into...',
            sortingAlgorithm: mergeSortAlgorithm,
          ),
        ),
        GetPage(
          name: '/quickSort',
          page: () => const SortingScreen(
            title: 'Quick Sort',
            description: 'Quick Sort works by partitioning the array...',
            sortingAlgorithm: quickSortAlgorithm,
          ),
        ),
      ],
    );
  }
}

class SortingHomePage extends StatelessWidget {
  const SortingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Sorting Visualizer',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Text(
                  'Nikita Kalher',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile1.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose a Sorting Algorithm',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              AlgorithmButton(
                algorithmName: 'Insertion Sort',
                algorithmRoute: '/insertionSort',
                icon: Icons.sort,
              ),
              AlgorithmButton(
                algorithmName: 'Selection Sort',
                algorithmRoute: '/selectionSort',
                icon: Icons.select_all,
              ),
              AlgorithmButton(
                algorithmName: 'Bubble Sort',
                algorithmRoute: '/bubbleSort',
                icon: Icons.bubble_chart,
              ),
              AlgorithmButton(
                algorithmName: 'Merge Sort',
                algorithmRoute: '/mergeSort',
                icon: Icons.merge_type,
              ),
              AlgorithmButton(
                algorithmName: 'Quick Sort',
                algorithmRoute: '/quickSort',
                icon: Icons.quickreply,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlgorithmButton extends StatelessWidget {
  final String algorithmName;
  final String algorithmRoute;
  final IconData icon;

  const AlgorithmButton({
    super.key,
    required this.algorithmName,
    required this.algorithmRoute,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white.withOpacity(0.9),
        child: ListTile(
          leading: Icon(icon, color: Colors.deepPurple, size: 30),
          title: Text(
            algorithmName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
          onTap: () {
            Get.toNamed(algorithmRoute);
          },
        ),
      ),
    );
  }
}
