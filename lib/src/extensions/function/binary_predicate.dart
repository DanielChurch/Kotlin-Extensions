import 'package:kotlin_extensions/typedefs.dart';

extension BinaryNegate<K, V> on BinaryPredicate<K, V> {
  BinaryPredicate<K, V> negate() => (K k, V v) => !this(k, v);
}

extension BinaryOr<K, V> on BinaryPredicate<K, V> {
  /// Returns a composed predicate that represents a short-circuiting
  /// logical OR of this predicate and another.
  /// 
  /// When evaluating the composed predicate, if this predicate is true,
  /// then the other predicate is not evaluated.
  /// 
  /// Any exceptions thrown during evaluation of either predicate are relayed to the caller;
  /// if evaluation of this predicate throws an exception, the other predicate will not be evaluated.
  BinaryPredicate<K, V> or(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate);

    return (K key, V value) => this(key, value) || predicate(key, value);
  }
}

extension BinaryAnd<K, V> on BinaryPredicate<K, V> {
  BinaryPredicate<K, V> and(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate);

    return (K key, V value) => this(key, value) && predicate(key, value);
  }
}
