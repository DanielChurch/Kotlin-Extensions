import '../object/object_extensions.dart';

extension KotlinIterableOfMapExtensions<K, V> on Iterable<Map<K, V>> {
  /// Returns a new [Map] containing all key-value pairs from the given collection.
  ///
  /// The returned [Map] preserves the entry iteration order of the original collection.
  /// If any of two pairs would have the same key the last one gets added to the map.
  ///
  /// Examples:
  /// ```Dart
  /// [{'Hello': 'World'}, {'Foo': 'Bar'}].toMap(); // => ({'Hello': 'World', 'Foo': 'Bar'})
  /// [0, 1, 2, 3].map((i) => {i: i + 1}).toMap(); // => {0: 1, 1: 2, 2: 3, 3: 4}
  /// [{'Hello': 'Foo'}, {'Hello': 'World'}].toMap(); // => {'Hello': 'World'}
  /// ```
  Map<K, V> toMap() => <K, V>{}.also((output) => forEach(output.addAll));
}
