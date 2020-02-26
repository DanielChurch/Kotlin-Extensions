extension Sorted<T extends Comparable> on List<T> {
  /// Returns a List of all elements sorted according to their natural sort order.
  ///
  /// The sort is stable. It means that equal elements preserve
  /// their order relative to each other after sorting.
  ///
  /// Example:
  /// ```Dart
  /// [3, 1, 2].sorted(); // => [1, 2, 3]
  /// ```
  List<T> sorted() => toList()..sort();
}

// TODO: why not Comparable<T>?
extension SortedDescending<T extends Comparable> on List<T> {
  /// Returns a [List] of all elements sorted descending according to their natural sort order.
  ///
  /// The sort is stable. It means that equal elements preserve their order relative to each other after sorting.
  ///
  /// Example:
  /// ```Dart
  /// [5, 2, 6].sortedDescending(); // => [6, 5, 2]
  /// ```
  List<T> sortedDescending() => sorted().reversed.toList();
}
