import 'package:kt_xt/typedefs.dart';

import '../iterable/iterable_map.dart';
import '../iterable/iterable_object.dart';
import '../object/object.dart';

// TODO: should we copy the doc string here too?
extension Get<K, V> on Map<K, V> {
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
  /// print(m?.get('Hello')?.get('World')?.get('Foo')?.get('Bar')); // 5
  /// print(m2?.get('Hello')?.get('World')?.get('Foo')?.get('Bar')); // null
  /// ```
  V get(K key) =>
      this[key]; // TODO: is `get` bad to use since it's a reserved keyword?
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
  // TODO: should this be part of `get` to align with Dart? (eg. firstWhere(() {}, orElse: () {}))
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
    return this[key] ?? defaultValue();
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
    return Map.fromIterables(keys, values.map(transform));
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
    return Map.fromIterables(keys.map(transform), values);
  }
}

// TODO: add documentation below

extension Any<K, V> on Map<K, V> {
  bool any(Predicate<Map<K, V>> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().any(predicate);
  }
}

extension AsIterable<K, V> on Map<K, V> {
  Iterable<Map<K, V>> asIterable() => keys.map((K key) => {key: this[key]});
}

extension Copy<K, V> on Map<K, V> {
  Map<K, V> copy() => Map.from(this); // TODO: name `toMap`?
}

extension Every<K, V> on Map<K, V> {
  bool every(Predicate<Map<K, V>> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().every(predicate);
  }
}

extension FlatMap<K, V> on Map<K, V> {
  Iterable<R> flatMap<R>(Transform<Map<K, V>, Iterable<R>> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().flatMap(transform);
  }
}

extension GetValue<K, V> on Map<K, V> {
  V getValue(K key) {
    final result = get(key);

    if (result == null) throw StateError('No Element');

    return get(key);
  }
}

extension IsNullOrEmpty<K, V> on Map<K, V> {
  bool get isNullOrEmpty => this == null || isEmpty;
}

extension Length<K, V> on Map<K, V> {
  int get length => keys.length;
}

extension MapNotNull<K, V> on Map<K, V> {
  Iterable<R> mapNotNull<R>(Transform<Map<K, V>, R> transform) {
    ArgumentError.checkNotNull(transform, 'transform');

    return asIterable().mapNotNull(transform);
  }
}

extension MaxBy<K, V> on Map<K, V> {
  Map<K, V> maxBy<R extends Comparable<R>>(Selector<Map<K, V>, R> selector) {
    // TODO: why not Comparable<T>?
    ArgumentError.checkNotNull(selector, 'selector');

    return asIterable().maxBy(selector);
  }
}

extension MaxWith<K, V> on Map<K, V> {
  Map<K, V> maxWith(Comparator<Map<K, V>> compare) {
    ArgumentError.checkNotNull(compare, 'compare');

    return asIterable().maxWith(compare);
  }
}

extension MinBy<K, V> on Map<K, V> {
  Map<K, V> minBy<R extends Comparable<R>>(Selector<Map<K, V>, R> selector) {
    // TODO: why not Comparable<T>?
    ArgumentError.checkNotNull(selector, 'selector');

    return asIterable().minBy(selector);
  }
}

extension MinWith<K, V> on Map<K, V> {
  Map<K, V> minWith(Comparator<Map<K, V>> compare) {
    ArgumentError.checkNotNull(compare, 'comapre');

    return asIterable().minWith(compare);
  }
}

extension None<K, V> on Map<K, V> {
  bool none(Predicate<Map<K, V>> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().none(predicate);
  }
}

extension OnEach<K, V> on Map<K, V> {
  Map<K, V> onEach(Action<Map<K, V>> action) {
    ArgumentError.checkNotNull(action, 'action');

    return also((Map<K, V> map) => map.asIterable().forEach(action));
  }
}

extension OrEmpty<K, V> on Map<K, V> {
  Map<K, V> orEmpty() => isNullOrEmpty ? {} : this;
}

extension Plus<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> rhs) {
    if (rhs == null) throw ArgumentError('both maps must not be null');

    return copy()..addAll(rhs);
  }
}

extension ToList<K, V> on Map<K, V> {
  List<Map<K, V>> toList() => asIterable().toList();
}

extension Where<K, V> on Map<K, V> {
  Map<K, V> where(Predicate<Map<K, V>> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return asIterable().where(predicate).toMap();
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
  Map<K, V> whereNot(Predicate<Map<K, V>> predicate) {
    ArgumentError.checkNotNull(predicate, 'predicate');

    return where((Map<K, V> element) => !predicate(element));
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
