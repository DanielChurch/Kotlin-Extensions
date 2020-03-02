import 'package:kotlin_extensions/typedefs.dart';

extension BinaryAnd<K, V> on BinaryPredicate<K, V> {
  /// Returns a composed [BinaryPredicate] that represents a short-circuiting
  /// logical AND of this [BinaryPredicate] and another.
  ///
  /// When evaluating the composed [BinaryPredicate],
  /// if this [BinaryPredicate] is false, then the other [BinaryPredicate] is not evaluated.
  ///
  /// Any exceptions thrown during evaluation of either [BinaryPredicate] are relayed
  /// to the caller; if evaluation of this [BinaryPredicate] throws an exception,
  /// the other [BinaryPredicate] will not be evaluated.
  ///
  /// Related: [negate], [or]
  ///
  /// Examples:
  /// ```Dart
  /// bool areBothNonNull(int a, int b) => a != null && b != null;
  /// bool areEqual(int a, int b) => a == b;
  ///
  /// areBothNonNull.and(areEqual)(null, null); // => false
  /// areBothNonNull.and(areEqual)(4, 2); // => false
  /// areBothNonNull.and(areEqual)(2, 2); // => true
  /// ```
  BinaryPredicate<K, V> and(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate);

    return (K key, V value) => this(key, value) && predicate(key, value);
  }
}

extension BinaryNegate<K, V> on BinaryPredicate<K, V> {
  /// Returns a [BinaryPredicate] that represents the logical negation of this [Predicate].
  ///
  /// Related: [and], [or]
  ///
  /// Examples:
  /// ```Dart
  /// bool areBothNonNull(int a, int b) => a != null && b != null;
  ///
  /// areBothNonNull(null, 5); // => false
  /// areBothNonNull.negate()(null, 5); // => true
  /// ```
  BinaryPredicate<K, V> negate() => (K k, V v) => !this(k, v);
}

extension BinaryOr<K, V> on BinaryPredicate<K, V> {
  /// Returns a composed [BinaryPredicate] that represents a short-circuiting
  /// logical OR of this [BinaryPredicate] and another.
  ///
  /// When evaluating the composed [BinaryPredicate], if this [BinaryPredicate] is true,
  /// then the other [BinaryPredicate] is not evaluated.
  ///
  /// Any exceptions thrown during evaluation of either [BinaryPredicate] are relayed to the caller;
  /// if evaluation of this [BinaryPredicate] throws an exception,
  /// the other [BinaryPredicate] will not be evaluated.
  ///
  /// Related: [and], [negate]
  ///
  /// Examples:
  /// ```Dart
  /// bool areEitherNull(int a, int b) => a == null || b == null;
  /// bool doesSumToFive(int a, int b) => a + b == 5;
  ///
  /// areEitherNull.or(doesSumToFive)(null, 5); // => true
  /// areEitherNull.or(doesSumToFive)(0, 5); // => true
  /// ```
  BinaryPredicate<K, V> or(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate);

    return (K key, V value) => this(key, value) || predicate(key, value);
  }
}
