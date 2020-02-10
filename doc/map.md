# Map Extensions

- [On Map\<K, V\>](#on-mapk-v)
    - [get](#get)
    - [getOrDefault](#getOrDefault)
    - [getOrElse](#getOrElse)
    - [mapKeys](#mapKeys)
    - [mapValues](#mapValues)

## On `Map<K, V>`

### [`get`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/get.html)

Returns the value corresponding to the given `key`, or `null` if such a key is not present in the `Map`.

```Dart
V Map<K, V>.get(K key)
```

Related: [getOrDefault](#getOrDefault), [getOrElse](#getOrElse)

Examples:
```Dart
final withFoo = {'Hello': {'World': {'Foo': {'Bar': 5}}}};
final withoutFoo = {'Hello': {'World': {'Baz': {'Bar': 5}}}};

print(withFoo?.get('Hello')?.get('World')?.get('Foo')?.get('Bar')); // 5
print(withoutFoo?.get('Hello')?.get('World')?.get('Foo')?.get('Bar')); // null
```

### [`getOrDefault`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/get-or-default.html)

```Dart
V Map<K, V>.getOrDefault(K key, V defaultValue)
```

Returns the value corresponding to the given `key`, or `defaultValue` if such a `key` is not present in the `Map`.

Related: [get](#get), [getOrElse](#getOrElse)

Examples:
```Dart
print(<String, int>{'Hello': 5}.getOrDefault('World', 6)); // 6
print(<String, int>{'Hello': 5}.getOrDefault('Hello', 42)); // 5
```

### [`getOrElse`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/get-or-else.html)

```Dart
V Map<K, V>.getOrElse(K key, V Function() defaultValue)
```

Returns the value for the given `key`, or the result of the `defaultValue` function if there was no entry for the given `key`.

Related: [get](#get), [getOrDefault](#getOrDefault)

Examples:
```Dart
print(<String, int>{'Hello': 5}.getOrElse('World', () => 6)); // 6
print(<String, int>{'Hello': 5}.getOrElse('Hello', () => 42)); // 5
```

### [`mapKeys`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-keys.html)

```Dart
Map<R, V> Map<K, V>.mapKeys<R>(R Function(K) transform)
```

Returns a new `Map` with entries having the keys obtained by applying the `transform` function to each entry in this `Map` and the values of this `Map`.

- In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite the value associated with the former one.
- The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [mapValues](#mapValues)

Examples:
```Dart
final result = {0: 1, 2: 3}.mapKeys((k) => k + 5);

print(result); // {5: 1, 7: 3}
```

```Dart
final result = {0: 1, 2: 3}.mapKeys((i) => 0);

print(result); // {0: 3}
```

### [`mapValues`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-values.html)

```Dart
Map<K, R> Map<K, V>.mapValues(R Function(V) transform)
```

Returns a new `Map` with entries having the keys of this `Map` and the values obtained by applying the `transform` function to each entry in this `Map`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [mapKeys](#mapKeys)

Examples:
```Dart
final result = {0: 1, 2: 3}.mapValues((v) => v * 2);

print(result); // {0: 2, 2: 6}
```

```Dart
final result = {'Hello': 'World'}.mapValues((v) => '$v$v');

print(result); // {'Hello': 'WorldWorld'}
```

[reduce (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/reduce.html
[forEach (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/forEach.html
[map (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/map.html
[where (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/where.html
[last (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/last.html
[first (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/first.html