import 'package:kotlin_extensions/typedefs.dart';

extension BinaryNegate<K, V> on BinaryPredicate<K, V> {
  BinaryPredicate<K, V> negate() => (K k, V v) => !this(k, v);
}

extension BinarOr<K, V> on BinaryPredicate<K, V> {
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
