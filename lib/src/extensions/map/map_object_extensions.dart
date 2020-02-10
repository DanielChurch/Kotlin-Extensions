import 'package:kt_xt/typedefs.dart';

extension KotlinMapExtension<K, V> on Map<K, V> {
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
  V get(K key) => this[key];

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
