import 'package:kotlin_extensions/src/extensions/function/binary_predicate.dart'
    show BinaryNegate;
import 'package:kotlin_extensions/src/extensions/iterable/iterable_map.dart'
    show ToMap;
import 'package:kotlin_extensions/src/extensions/iterable/iterable_object.dart';
import 'package:kotlin_extensions/src/extensions/object/object.dart' show To;
import 'package:kotlin_extensions/typedefs.dart';

// TODO: verify we cleaned up from the map -> mapentry change

// TODO: should we copy the doc string here too?
extension Any<K, V> on Map<K, V> {
  /// Returns `true` if at least one entry matches the given [predicate].
  ///
  /// Related: [every], [none]
  ///
  /// Examples:
  /// ```Dart
  /// <int, int>{1: 2, 3: 4}.any((k, v) => k == 1); // => true
  /// <int, int>{1: 2, 3: 4}.any((k, v) => v == 4); // => true
  ///
  /// <int, int>{1: 2, 3: 4}.any((k, v) => k == 2); // false
  /// ```
  bool any(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().any(predicate.toUnary());
  }
}

extension AsIterable<K, V> on Map<K, V> {
  /// Creates a lazy [Iterable] instance that wraps the original `Map`
  /// returning its entries when being iterated.
  ///
  /// Related: [toList], [ToMap]
  ///
  /// Examples:
  /// ```Dart
  /// ```
  Iterable<MapEntry<K, V>> asIterable() {
    return keys.map((K key) => To(key).to(this[key]));
  }
}

extension Copy<K, V> on Map<K, V> {
  /// Returns a new read-only `Map` containing all key-value pairs
  /// from the original `Map`.
  ///
  /// The returned `Map` preserves the entry iteration order of the original `Map`.
  ///
  /// Related: [Map.from]
  ///
  /// Examples:
  /// ```Dart
  /// final map = {0: 1, 2: 3};
  /// print(map.copy()..remove(0)); // {2: 3}
  /// print(map); // {0: 1, 2: 3}
  /// ```
  Map<K, V> copy() => Map.from(this);

  // TODO:
  // Map<K, V> toMap() => Map.from(this);
  // Map<K, V> clone() => Map.from(this);
}

extension Every<K, V> on Map<K, V> {
  /// Returns `true` if all entries match the given [predicate].
  ///
  /// Related: [any], [none]
  ///
  /// Examples:
  /// ```Dart
  /// <int, int>{0: 1, 2: 3}.every((k, v) => k < 3); // => true
  /// <int, int>{0: 1, 2: 3}.every((k, v) => v < 4); // => true
  ///
  /// <int, int>{0: 1, 2: 3}.every((k, v) => v < 2); // => false
  /// <int, int>{0: 1, 2: 3}.every((k, v) => v < 3); // => false
  /// ```
  bool every(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().every(predicate.toUnary());
  }
}

extension FlatMap<K, V> on Map<K, V> {
  /// Returns a lazy [Iterable] of all elements yielded from results of
  /// [transform] function being invoked on each entry of original [Map].
  ///
  /// Related: [mapToIterable], [mapValues], [mapKeys]
  ///
  /// Example:
  /// ```Dart
  /// <int, int>{1: 2, 3: 4}.flatMap((k, v) => [k, v]); // => (1, 2, 3, 4)
  /// ```
  Iterable<R> flatMap<R>(BinaryTransform<K, V, Iterable<R>> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().flatMap(transform.toUnary());
  }
}

extension GetOrDefault<K, V> on Map<K, V> {
  /// Returns the value corresponding to the given [key], or
  /// [defaultValue] if such a [key] is not present in the [Map].
  ///
  /// Related: [get], [getOrElse], [getValue]
  ///
  /// Example:
  /// ```Dart
  /// <String, int>{'Hello': 5}.getOrDefault('World', 6); // 6
  /// <String, int>{'Hello': 5}.getOrDefault('Hello', 24); // 5
  /// ```
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;
}

extension GetOrElse<K, V> on Map<K, V> {
  /// Returns the value for the given [key], or the result of the
  /// [defaultValue] function if there was no entry for the given [key].
  ///
  /// Related: [get], [getOrDefault], [getValue]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 5}.getOrElse('World', () => 6); // 6
  /// <String, int>{'Hello': 5}.getOrElse('Hello', () => 42); // 5
  /// ```
  V getOrElse(K key, V Function() defaultValue) {
    ArgumentError.checkNotNull(defaultValue, 'defaultValue');

    return this[key] ?? defaultValue();
  }
}

extension GetOrNull<K, V> on Map<K, V> {
  /// Returns the value corresponding to the given [key],
  /// or `null` if such a [key] is not present in the [Map].
  ///
  /// Related: [getOrDefault], [getOrElse], [getValue]
  ///
  /// Example:
  /// ```Dart
  /// final m = {'Hello': {'World': {'Foo': {'Bar': 5}}}};
  /// final m2 = {'Hello': {'World': {'Baz': {'Bar': 5}}}};
  ///
  /// print(m?.getOrNull('Hello')?.getOrNull('World')?.getOrNull('Foo')?.getOrNull('Bar')); // 5
  /// print(m2?.getOrNull('Hello')?.getOrNull('World')?.getOrNull('Foo')?.getOrNull('Bar')); // null
  /// ```
  V getOrNull(K key) => this[key];

  // TODO
  // V valueFor(K key) => this[key];
  // V valueAt(K key) => this[key];
  // V get(K key) => this[key];
}

extension GetValue<K, V> on Map<K, V> {
  /// Returns the value for the given [key] or throws a [StateError]
  /// if there is no such key in the `Map`.
  ///
  /// Related: [getOrNull], [getOrDefault], [getOrElse]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hi': 2}.getValue('Hi'); // => 2
  /// <String, int>{'Hi': 2}.getValue('Hello'); // => throw StateError
  /// ```
  V getValue(K key) {
    final result = getOrNull(key);

    if (result == null) throw StateError('No Element');

    return getOrNull(key);
  }
}

extension IsNullOrEmpty<K, V> on Map<K, V> {
  /// Returns `true` if this [Map] is either `null` or empty.
  ///
  /// Related: [isEmpty], [orEmpty]
  ///
  /// Examples:
  /// ```Dart
  /// <int, int>{}.isNullOrEmpty; // => true
  /// <int, int>{}.isNullOrEmpty; // => true
  ///
  /// <int, int>{0: 1}.isNullOrEmpty; // => false
  /// ```
  bool get isNullOrEmpty => this == null || isEmpty;
}

extension MapKeys<K, V> on Map<K, V> {
  /// Returns a new [Map] with [entries] having the [keys] obtained by applying
  /// the [transform] function to each entry in this [Map] and the [values] of [this] [Map].
  ///
  /// In case if any two [entries] are mapped to the equal [keys], the value
  /// of the latter one will overwrite the value associated with the former one.
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [mapValues], [map], [mapToIterable], [mapNotNull]
  ///
  /// Examples:
  /// ```Dart
  /// {0: 1, 2: 3}.mapKeys((k) => k + 5); // => {5: 1, 7: 3}
  /// {0: 1, 2: 3}.mapKeys((i) => 0); // => {0: 3}
  /// ```
  Map<R, V> mapKeys<R>(Transform<K, R> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return Map.fromIterables(keys.map(transform), values);
  }
}

extension MapNotNull<K, V> on Map<K, V> {
  /// Returns a lazy [Iterable] containing only the non-null results of applying
  /// the given [transform] function to each entry in the original [Map].
  ///
  /// Related: [mapToIterable], [map], [mapKeys], [mapValues]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hi': 2, 'Yo': null}.mapNotNull((k, v) => v); // => [2]
  /// ```
  Iterable<R> mapNotNull<R>(BinaryTransform<K, V, R> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().mapNotNull(transform.toUnary());
  }
}

extension MapToIterable<K, V> on Map<K, V> {
  /// Returns a lazy [Iterable] containing the results of applying the given
  /// [transform] function to each entry in the original [Map].
  ///
  /// Related: [map], [mapKeys], [mapValues], [mapNotNull]
  ///
  /// Example:
  /// ```Dart
  /// <int, int>{1: 2, 3: 4}.mapToIterable((k, v) => k + v); // => (3, 7)
  /// ```
  Iterable<T> mapToIterable<T>(BinaryTransform<K, V, T> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().map((entry) => transform(entry.key, entry.value));
  }
}

extension MapValues<K, V> on Map<K, V> {
  /// Returns a new [Map] with [entries] having the keys of this [Map] and the
  /// [values] obtained by applying the [transform] function to each entry in this [Map].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [mapKeys], [map], [mapToIterable], [mapNotNull]
  ///
  /// Examples:
  /// ```Dart
  /// {0: 1, 2: 3}.mapValues((v) => v * 2); // => {0: 2, 2: 6}
  /// {'Hello': 'World'}.mapValues((v) => '$v$v'); // => {'Hello': 'WorldWorld'}
  /// ```
  Map<K, R> mapValues<R>(Transform<V, R> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return Map.fromIterables(keys, values.map(transform));
  }
}

extension MaxBy<K, V> on Map<K, V> {
  /// Returns the first entry yielding the largest value of the given function
  /// or `null` if there are no entries.
  ///
  /// Related: [maxWith], [minBy], [minWith]
  ///
  /// Examples:
  /// ```Dart
  /// <int, int>{5: 20, 7: 9}.maxBy((k, v) => k); // => {7: 9}
  /// <int, int>{5: 20, 7: 9}.maxBy((k, v) => v); // => {5: 20}
  /// ```
  MapEntry<K, V> maxBy<R extends Comparable>(
    BinarySelector<K, V, R> selector,
  ) {
    ArgumentError.checkNotNull(selector, 'selector');

    return asIterable().maxBy(selector.toUnary());
  }
}

extension MaxWith<K, V> on Map<K, V> {
  /// Returns the first entry having the largest value according to the
  /// provided [compare] or `null` if there are no entries.
  ///
  /// Related: [maxBy], [minBy], [minWith]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 2, 'Yo': 3}.maxWith(
  ///   (e1, e2) => e1.key.length.compareTo(e2.key.length),
  /// ); // => MapEntry('Hello', 2)
  /// ```
  MapEntry<K, V> maxWith(Comparator<MapEntry<K, V>> compare) {
    ArgumentError.checkNotNull(compare, 'compare');

    return asIterable().maxWith(compare);
  }
}

extension MinBy<K, V> on Map<K, V> {
  /// Returns the first entry yielding the smallest value of the given
  /// [selector] or `null` if there are no entries.
  ///
  /// Related: [minWith], [maxWith], [maxBy]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 2, 'Yo': 3}.minBy((k, v) => k.length); // => {'Yo': 3}
  /// <String, int>{'Hello': 2, 'Yo': 3}.minBy((k, v) => v); // => {'Hello': 2}
  /// ```
  MapEntry<K, V> minBy<R extends Comparable>(BinarySelector<K, V, R> selector) {
    ArgumentError.checkNotNull(selector, 'selector');

    return asIterable().minBy(selector.toUnary());
  }
}

extension MinWith<K, V> on Map<K, V> {
  /// Returns the first entry having the smallest value according to the
  /// provided [compare] function or `null` if there are no entries.
  ///
  /// Related: [minBy], [maxWith], [maxBy]
  ///
  /// Examples:
  /// ```Dart
  /// TODO
  /// ```
  MapEntry<K, V> minWith(Comparator<MapEntry<K, V>> compare) {
    ArgumentError.checkNotNull(compare, 'compare');

    return asIterable().minWith(compare);
  }
}

extension None<K, V> on Map<K, V> {
  /// Returns `true` if no entries match the given [predicate].
  ///
  /// Related: [any], [every]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 1, 'World': 2}.none((k, v) => k == 'Foo'); // => true
  /// <String, int>{'Hello': 1, 'World': 2}.none((k, v) => v == 42); // => true
  ///
  /// <String, int>{'Hello': 1, 'World': 2}.none((k, v) => k == 'Hello'); // => false
  /// <String, int>{'Hello': 1, 'World': 2}.none((k, v) => v == 2); // => false
  /// ```
  bool none(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().none(predicate.toUnary());
  }
}

extension OnEach<K, V> on Map<K, V> {
  /// Performs the given [action] on each entry and returns
  /// the [Map] itself afterwards.
  ///
  /// Related: [forEach]
  ///
  /// Examples:
  /// ```Dart
  /// TODO
  /// ```
  Map<K, V> onEach(BinaryAction<K, V> action) {
    ArgumentError.checkNotNull(action, 'action');

    asIterable().forEach(action.toUnary());

    return this;
  }
}

extension OrEmpty<K, V> on Map<K, V> {
  /// Returns the [Map] if its not `null`, or an empty [Map] otherwise.
  ///
  /// Related: [isNullOrEmpty]
  ///
  /// Examples:
  /// ```Dart
  /// Map map;
  /// final orEmpty = map.orEmpty();
  /// print(map.prEmpty); // => {}
  /// ```
  ///
  /// ```Dart
  /// Map map = {0: 1};
  /// final orEmpty = map.orEmpty();
  ///
  /// identical(map, orEmpty); // => true (same Map reference)
  /// ```
  Map<K, V> orEmpty() => this ?? {};
}

extension Plus<K, V> on Map<K, V> {
  /// Creates a new [Map] by replacing or adding entries
  /// to this [Map] from another [Map].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Those entries of another [Map] that are missing in this [Map] are iterated
  /// in the end in the order of that [Map].
  ///
  /// Related: [addAll]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 1} + <String, int>{'Hi': 2}; // => {'Hello': 1, 'Hi': 2}
  /// <String, int>{'Hi': 1} + <String, int>{'Hi': 2}; // => {'Hi': 2}
  /// ```
  Map<K, V> operator +(Map<K, V> rhs) {
    if (this == null || rhs == null) {
      throw ArgumentError('both maps must not be null');
    }

    return copy()..addAll(rhs);
  }
}

extension ToList<K, V> on Map<K, V> {
  /// Returns a [List] containing all key-value pairs.
  ///
  /// Related: [mapToIterable], [ToMap]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 1, 'World': 2}.toList(); // => [{'Hello': 1}, {'World': 2}]
  /// ```
  List<MapEntry<K, V>> toList() => asIterable().toList();
}

extension Where<K, V> on Map<K, V> {
  /// Returns a new [Map] containing all key-value pairs matching the given [predicate].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [whereKeys], [whereNot], [whereValues]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 1, 'World': 2}.where((k, v) => k.contains('ello'));
  /// // => {'Hello': 1}
  ///
  /// <String, int>{'Hello': 1, 'World': 2}.where((k, v) => v < 2);
  /// // => {'Hello': 1}
  /// ```
  Map<K, V> where(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().where(predicate.toUnary()).toMap();
  }
}

extension WhereKeys<K, V> on Map<K, V> {
  /// Returns a [Map] containing all key-value pairs with keys matching the given [predicate].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [where], [whereNot], [whereValues]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 1, 'World': 2}.whereKeys((k) => k.contains('ello'));
  /// // => {'Hello': 1}
  ///
  /// <String, int>{'Hello': 1, 'Jello': 2}.whereKeys((k) => k.contains('ello'));
  /// // => {'Hello': 1, 'Jello': 2}
  /// ```
  Map<K, V> whereKeys(Predicate<K> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable()
        .where((MapEntry<K, V> entry) => predicate(entry.key))
        .toMap();
  }
}

extension WhereNot<K, V> on Map<K, V> {
  /// Returns a new [Map] containing all key-value pairs not matching the given [predicate].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [where], [whereKeys], [whereValues]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 1, 'Hi': 2}.whereNot((k, v) => k.contains('ello'));
  /// // => {'Hi': 2}
  /// ```
  Map<K, V> whereNot(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return where(predicate.negate());
  }
}

extension WhereValues<K, V> on Map<K, V> {
  /// Returns a [Map] containing all key-value pairs with values matching the given [predicate].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [where], [whereKeys], [whereNot]
  ///
  /// Examples:
  /// ```Dart
  /// <String, int>{'Hello': 2, 'Hi': 1}.whereValues((v) => v > 1);
  /// // => {'Hello': 2}
  /// ```
  Map<K, V> whereValues(Predicate<V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable()
        .where((MapEntry<K, V> entry) => predicate(entry.value))
        .toMap();
  }
}
