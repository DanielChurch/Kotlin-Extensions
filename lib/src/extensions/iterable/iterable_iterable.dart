import 'package:kotlin_extensions/src/util/generic_function_helper.dart';

extension Flatten<T> on Iterable<Iterable<T>> {
  /// Returns a flat [Iterable] of all elements from all Iterables in the given collection.
  ///
  /// Related: [flatMap]
  ///
  /// Examples:
  /// ```Dart
  /// [[0, 1], [2, 3]].flatten(); // => [0, 1, 2, 3]
  /// [[[0, 1], [2, 3]], [4, 5]].flatten(); // => [[0, 1], [2, 3], 4, 5]
  /// [[[0, 1], [2, 3]].flatten(), [4, 5]].flatten(); // => [0, 1, 2, 3, 4, 5]
  /// ```
  Iterable<T> flatten() => expand(identity);
}
