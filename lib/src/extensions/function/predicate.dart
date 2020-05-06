import 'package:kotlin_extensions/typedefs.dart';

extension And<T> on Predicate<T> {
  /// Returns a composed [Predicate] that represents a short-circuiting
  /// logical AND of this [Predicate] and another.
  ///
  /// When evaluating the composed [Predicate],
  /// if this [Predicate] is false, then the other [Predicate] is not evaluated.
  ///
  /// Any exceptions thrown during evaluation of either [Predicate] are relayed
  /// to the caller; if evaluation of this [Predicate] throws an exception,
  /// the other [Predicate] will not be evaluated.
  ///
  /// Related: [negate], [or]
  ///
  /// Examples:
  /// ```Dart
  /// bool isLessThanFive(int value) => value < 5;
  /// bool isMoreThanThree(int value) => value > 3;
  ///
  /// [2, 3, 4, 5, 6].where(isLessThanFive.and(isMoreThanThree)); // => (4)
  /// ```
  Predicate<T> and(Predicate<T> predicate) {
    ArgumentError.checkNotNull('predicate');

    return (T element) => this(element) && predicate(element);
  }
}

extension Negate<T> on Predicate<T> {
  /// Returns a [Predicate] that represents the logical negation of this [Predicate].
  ///
  /// Related: [and], [or]
  ///
  /// Examples:
  /// ```Dart
  /// bool isLessThanThree(int value) => value < 3;
  ///
  /// [2, 3, 4].where(isLessThanThree); // => (2)
  /// [2, 3, 4].where(isLessThanThree.negate()); // => (3, 4)
  /// ```
  Predicate<T> negate() => (T element) => !this(element);
}

extension Or<T> on Predicate<T> {
  /// Returns a composed [Predicate] that represents a short-circuiting
  /// logical OR of this [Predicate] and another.
  ///
  /// When evaluating the composed [Predicate], if this [Predicate] is true,
  /// then the other [Predicate] is not evaluated.
  ///
  /// Any exceptions thrown during evaluation of either [Predicate] are relayed to the caller;
  /// if evaluation of this [Predicate] throws an exception,
  /// the other [Predicate] will not be evaluated.
  ///
  /// Related: [and], [negate]
  ///
  /// Examples:
  /// ```Dart
  /// bool isLessThanThree(int value) => value < 3;
  /// bool isMoreThanFive(int value) => value > 5;
  ///
  /// [2, 3, 4, 5, 6].where(isLessThanThree.or(isMoreThanFive)); // => (2, 6)
  /// ```
  Predicate<T> or(Predicate<T> predicate) {
    ArgumentError.checkNotNull(predicate);

    return (T element) => this(element) || predicate(element);
  }
}
