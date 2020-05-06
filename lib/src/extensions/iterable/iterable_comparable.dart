import 'package:kotlin_extensions/src/extensions/iterable/iterable_object.dart'
    show ReduceOrNull;
import 'package:kotlin_extensions/src/util/generic_compareable_helper.dart'
    show genericMax, genericMin;

extension Max<T extends Comparable> on Iterable<T> {
  /// Returns the largest element or `null` if there are no elements.
  ///
  /// Related: [maxBy], [maxWith], [min], [minBy], [minWith]
  ///
  /// Examples:
  /// ```Dart
  /// [8, 10, 2].max; // => 10
  /// [].max; // => null
  /// ```
  T get max => reduceOrNull(genericMax);
}

extension Min<T extends Comparable> on Iterable<T> {
  /// Returns the smallest element or `null` if there are no elements.
  ///
  /// Related: [minBy], [minWith], [max], [maxBy], [maxWith]
  ///
  /// Examples:
  /// ```Dart
  /// [8, 10, 2].min; // => 2
  /// [].min; // => null
  /// ```
  T get min => reduceOrNull(genericMin);
}
