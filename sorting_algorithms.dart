import 'sorting_controller.dart';

void insertionSortAlgorithm(SortingController controller) async {
  var array = controller.pillars.toList();
  for (int i = 1; i < array.length; i++) {
    int key = array[i];
    int j = i - 1;

    await controller.checkPause(); // Check pause

    while (j >= 0 && array[j] > key) {
      array[j + 1] = array[j];
      j--;

      // Update observable list
      controller.pillars.value = array;
      await controller.wait(); // Wait according to speed
    }
    array[j + 1] = key;
    controller.pillars.value = array;
  }
}


// Selection Sort
void selectionSortAlgorithm(SortingController controller) async {
  var array = controller.pillars.toList();
  for (int i = 0; i < array.length - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < array.length; j++) {
      await controller.checkPause(); // Check pause
      if (array[j] < array[minIndex]) {
        minIndex = j;
      }
    }

    // Swap the found minimum element with the first element
    if (minIndex != i) {
      int temp = array[i];
      array[i] = array[minIndex];
      array[minIndex] = temp;

      // Update observable list
      controller.pillars.value = array;
    }
    await controller.wait(); // Wait according to speed
  }
}


void bubbleSortAlgorithm(SortingController controller) async {
  var array = controller.pillars.toList();
  for (int i = 0; i < array.length - 1; i++) {
    for (int j = 0; j < array.length - i - 1; j++) {
      // Check pause before each comparison
      await controller.checkPause();

      if (array[j] > array[j + 1]) {
        // Swap
        int temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;

        // Update observable list
        controller.pillars.value = array;
      }
      // Wait according to speed
      await controller.wait();
    }
  }
}


// Merge Sort
void mergeSortAlgorithm(SortingController controller) async {
  var array = controller.pillars.toList();
  await mergeSort(array, 0, array.length - 1, controller);
}

Future<void> mergeSort(List<int> array, int left, int right, SortingController controller) async {
  if (left < right) {
    int mid = (left + right) ~/ 2;

    // Sort first and second halves
    await mergeSort(array, left, mid, controller);
    await mergeSort(array, mid + 1, right, controller);

    await merge(array, left, mid, right, controller);
  }
}

Future<void> merge(List<int> array, int left, int mid, int right, SortingController controller) async {
  int n1 = mid - left + 1;
  int n2 = right - mid;

  List<int> leftArray = List.filled(n1, 0);
  List<int> rightArray = List.filled(n2, 0);

  for (int i = 0; i < n1; i++) {
    leftArray[i] = array[left + i];
  }
  for (int j = 0; j < n2; j++) {
    rightArray[j] = array[mid + 1 + j];
  }

  int i = 0, j = 0, k = left;

  while (i < n1 && j < n2) {
    await controller.checkPause();
    if (leftArray[i] <= rightArray[j]) {
      array[k] = leftArray[i];
      i++;
    } else {
      array[k] = rightArray[j];
      j++;
    }
    k++;
    controller.pillars.value = array; // Update observable list
    await controller.wait(); // Wait according to speed
  }

  while (i < n1) {
    array[k] = leftArray[i];
    i++;
    k++;
    controller.pillars.value = array; // Update observable list
    await controller.wait();
  }

  while (j < n2) {
    array[k] = rightArray[j];
    j++;
    k++;
    controller.pillars.value = array; // Update observable list
    await controller.wait();
  }
}


// Quick Sort
void quickSortAlgorithm(SortingController controller) async {
  var array = controller.pillars.toList();
  await quickSort(array, 0, array.length - 1, controller);
}

Future<void> quickSort(List<int> array, int low, int high, SortingController controller) async {
  if (low < high) {
    int pi = await partition(array, low, high, controller);

    // Recursively sort elements before and after partition
    await quickSort(array, low, pi - 1, controller);
    await quickSort(array, pi + 1, high, controller);
  }
}

Future<int> partition(List<int> array, int low, int high, SortingController controller) async {
  int pivot = array[high];
  int i = low - 1;

  for (int j = low; j < high; j++) {
    await controller.checkPause(); // Check pause
    if (array[j] < pivot) {
      i++;
      // Swap array[i] and array[j]
      int temp = array[i];
      array[i] = array[j];
      array[j] = temp;

      controller.pillars.value = array; // Update observable list
      await controller.wait(); // Wait according to speed
    }
  }

  // Swap array[i + 1] and array[high] (pivot)
  int temp = array[i + 1];
  array[i + 1] = array[high];
  array[high] = temp;

  controller.pillars.value = array; // Update observable list
  await controller.wait(); // Wait according to speed

  return i + 1;
}
