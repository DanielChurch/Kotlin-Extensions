// Represents a predicate (boolean-valued function) of one argument.
typedef Predicate<T> = bool Function(T);
typedef BinaryPredicate<T, K> = bool Function(T, K);
typedef IndexedPredicate<T> = bool Function(int, T);

typedef Transform<T, R> = R Function(T);
typedef BinaryTransform<T, K, R> = R Function(T, K);
typedef IndexedTransform<T, R> = R Function(int, T);

typedef Selector<T, R> = R Function(T);
typedef BinarySelector<T, K, R> = R Function(T, K);

typedef Action<T> = void Function(T);
typedef BinaryAction<T, K> = void Function(T, K);
typedef IndexedAction<T> = void Function(int, T);

typedef Block<T, R> = R Function(T);

typedef BinaryComparator<K, V> = int Function(K k1, V v1, K k2, V v2);

typedef Combine<T> = T Function(T, T);
typedef IndexedCombine<T> = T Function(int, T, T);

extension ToUnary<K, V, R> on BinaryTransform<K, V, R> {
  Transform<MapEntry<K, V>, R> toUnary() {
    return (entry) => this(entry.key, entry.value);
  }
}

// extension ToUnaryPredicate<K, V> on BinaryPredicate<K, V> {
//   Predicate<Map<K, V>> toUnary() {
//     return (Map<K, V> mapEntry) {
//       return mapEntry.keys.every((k) => this(k, mapEntry[k]));
//     };
//   }
// }
