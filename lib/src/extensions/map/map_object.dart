import 'package:kotlin_extensions/typedefs.dart';

import '../function/function_predicate.dart';
import '../iterable/iterable_map.dart';
import '../iterable/iterable_object.dart';

// TODO: should we copy the doc string here too?
extension GetOrNull<K, V> on Map<K, V> {
  /// Returns the value corresponding to the given [key],
  /// or `null` if such a [key] is not present in the [Map].
  ///
  /// Related: [getOrDefault], [getOrElse]
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

extension GetOrDefault<K, V> on Map<K, V> {
  /// Returns the value corresponding to the given [key], or
  /// [defaultValue] if such a [key] is not present in the [Map].
  ///
  /// Related: [get], [getOrElse]
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
  /// Related: [get], [getOrDefault]
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

extension MapKeys<K, V> on Map<K, V> {
  /// Returns a new [Map] with [entries] having the [keys] obtained by applying
  /// the [transform] function to each entry in this [Map] and the [values] of [this] [Map].
  ///
  /// In case if any two [entries] are mapped to the equal [keys], the value
  /// of the latter one will overwrite the value associated with the former one.
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [mapValues]
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

extension MapValues<K, V> on Map<K, V> {
  /// Returns a new [Map] with [entries] having the keys of this [Map] and the
  /// [values] obtained by applying the [transform] function to each entry in this [Map].
  ///
  /// The returned [Map] preserves the entry iteration order of the original [Map].
  ///
  /// Related: [mapKeys]
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

// TODO: add documentation below

extension MapToIterable<K, V> on Map<K, V> {
  Iterable<T> mapToIterable<T>(BinaryTransform<K, V, T> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().map((m) => transform(m.keys.single, m.values.single));
  }
}

extension Any<K, V> on Map<K, V> {
  bool any(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().any(predicate.toUnary());
  }
}

extension AsIterable<K, V> on Map<K, V> {
  Iterable<Map<K, V>> asIterable() => keys.map((K key) => {key: this[key]});
}

extension Copy<K, V> on Map<K, V> {
  Map<K, V> copy() => Map.from(this);

  // TODO:
  // Map<K, V> toMap() => Map.from(this);
  // Map<K, V> clone() => Map.from(this);
}

extension Every<K, V> on Map<K, V> {
  bool every(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().every(predicate.toUnary());
  }
}

extension FlatMap<K, V> on Map<K, V> {
  Iterable<R> flatMap<R>(BinaryTransform<K, V, Iterable<R>> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().flatMap(transform.toUnary());
  }
}

extension GetValue<K, V> on Map<K, V> {
  V getValue(K key) {
    final result = getOrNull(key);

    if (result == null) throw StateError('No Element');

    return getOrNull(key);
  }
}

extension IsNullOrEmpty<K, V> on Map<K, V> {
  bool get isNullOrEmpty => this == null || isEmpty;
}

extension MapNotNull<K, V> on Map<K, V> {
  Iterable<R> mapNotNull<R>(BinaryTransform<K, V, R> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().mapNotNull(transform.toUnary());
  }
}

extension MaxBy<K, V> on Map<K, V> {
  Map<K, V> maxBy<R extends Comparable>(BinarySelector<K, V, R> selector) {
    ArgumentError.checkNotNull(selector, 'selector');

    return asIterable().maxBy(selector.toUnary());
  }
}

extension MaxWith<K, V> on Map<K, V> {
  Map<K, V> maxWith(BinaryComparator<K, V> compare) {
    ArgumentError.checkNotNull(compare, 'compare');

    return asIterable().maxWith((m1, m2) {
      return compare(
        m1.keys.single,
        m1.values.single,
        m2.keys.single,
        m2.values.single,
      );
    });
  }
}

extension MinBy<K, V> on Map<K, V> {
  Map<K, V> minBy<R extends Comparable>(BinarySelector<K, V, R> selector) {
    ArgumentError.checkNotNull(selector, 'selector');

    return asIterable().minBy(selector.toUnary());
  }
}

extension MinWith<K, V> on Map<K, V> {
  // TODO:
  Map<K, V> minWith(BinaryComparator<K, V> compare) {
    ArgumentError.checkNotNull(compare, 'compare');

    return asIterable().minWith((m1, m2) {
      return compare(
        m1.keys.single,
        m1.values.single,
        m2.keys.single,
        m2.values.single,
      );
    });
  }
}

extension None<K, V> on Map<K, V> {
  bool none(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().none(predicate.toUnary());
  }
}

extension OnEach<K, V> on Map<K, V> {
  Map<K, V> onEach(BinaryAction<K, V> action) {
    ArgumentError.checkNotNull(action, 'action');

    asIterable().forEach(action.toUnary());

    return this;
  }
}

extension OrEmpty<K, V> on Map<K, V> {
  Map<K, V> orEmpty() => this ?? {};
}

extension Plus<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> rhs) {
    if (this == null || rhs == null) {
      throw ArgumentError('both maps must not be null');
    }

    return copy()..addAll(rhs);
  }
}

extension ToList<K, V> on Map<K, V> {
  List<Map<K, V>> toList() => asIterable().toList();
}

extension Where<K, V> on Map<K, V> {
  Map<K, V> where(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().where(predicate.toUnary()).toMap();
  }
}

extension WhereKeys<K, V> on Map<K, V> {
  Map<K, V> whereKeys(Predicate<K> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable()
        .where((Map<K, V> map) => predicate(map.keys.firstOrNull))
        .toMap();
  }
}

extension WhereNot<K, V> on Map<K, V> {
  Map<K, V> whereNot(BinaryPredicate<K, V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return where(predicate.negate());
  }
}

extension WhereValues<K, V> on Map<K, V> {
  Map<K, V> whereValues(Predicate<V> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable()
        .where((Map<K, V> map) => predicate(map.values.firstOrNull))
        .toMap();
  }
}
