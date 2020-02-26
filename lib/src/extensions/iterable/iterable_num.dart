import 'iterable_object.dart';

extension Sum<T extends num> on Iterable<T> {
  /// Returns the sum of all elements in the collection.
  ///
  /// Returns 0 if [isEmpty].
  ///
  /// Example:
  /// ```Dart
  /// <num>[].sum; // => null
  /// [1, 2, 3].sum; // => 6
  /// ```
  num get sum => reduceOrNull((i, j) => i + j) ?? 0;
}

extension Average<T extends num> on Iterable<T> {
  /// Returns an average value of elements in the collection.
  ///
  /// Returns [NaN] if [isEmpty].
  ///
  /// Example:
  /// ```Dart
  /// <num>[].average; // => NaN
  /// [1, 2, 3].average; // => 2
  /// ```
  num get average => sum / length;
}
