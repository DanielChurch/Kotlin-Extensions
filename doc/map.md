# Map Extensions

- [On Map\<K, V\>](#on-mapk-v)
    - [any]
    - [asIterable]
    - [copy]
    - [every]
    - [flatMap]
    - [getOrDefault]
    - [getOrElse]
    - [getOrNull]
    - [getValue]
    - [isNullOrEmpty]
    - [mapKeys]
    - [mapNotNull]
    - [mapToIterable]
    - [mapValues]
    - [maxBy]
    - [maxWith]
    - [minBy]
    - [minWith]
    - [none]
    - [onEach]
    - [orEmpty]
    - [plus]
    - [toList]
    - [where]
    - [whereKeys]
    - [whereNot]
    - [whereValues]
- [On Map\<K extends Comparable\<K\>\>](#on-mapk-extends-comparablek)

## On `Map<K, V>`

### [`any`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/any.html)

Returns `true` if at least one entry matches the given `predicate`.

Related: Related: [every], [none]

Examples:
```Dart
print({1: 2, 3: 4}.any((k, v) => k == 1)); // => true
print({1: 2, 3: 4}.any((k, v) => v == 4)); // => true

print({1: 2, 3: 4}.any((k, v) => k == 2)); // => false
```

### [`asIterable`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/as-iterable.html)

```Dart
Iterable<MapEntry<K, V>> Map<K, V>.asIterable()
```

Creates a lazy `Iterable` that wraps the original `Map` returning its entries when being iterated.

Related: [toList], [toMap]

Examples:
```Dart
print({1: 2, 3: 4}.asIterable()); // => [MapEntry(1, 2), MapEntry(3, 4)]
```

### [`copy (Kotlin toMap)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/to-map.html)

```Dart
Map<K, V> Map<K, V>.copy()
```

Returns a new read-only `Map` containing all key-value pairs from the original `Map`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [Map.from (Dart)]

```Dart
final map = {0: 1, 2: 3};
print(map.copy()..remove(0)); // {2: 3}
print(map); // {0: 1, 2: 3}
```

### [`every (Kotlin all)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/all.html)

```Dart
bool Map<K, V>.every(bool Function(K, V) predicate)
```

Returns `true` if all entries match the given `predicate`.

Related: [any], [none]

Examples:
```Dart
print(<int, int>{0: 1, 2: 3}.every((k, v) => k < 3)); // => true
print(<int, int>{0: 1, 2: 3}.every((k, v) => v < 4)); // => true

print(<int, int>{0: 1, 2: 3}.every((k, v) => v < 2)); // => false
print(<int, int>{0: 1, 2: 3}.every((k, v) => v < 3)); // => false
```

### [`flatMap`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/flat-map.html)

```Dart
Iterable<T> Map<K, V>.flatMap<R>(R Function(K, V) transform)
```

Returns a lazy `Iterable` of all elements yielded from results of transform function being invoked on each entry of original `Map`.

Related: [mapToIterable], [mapValues], [mapKeys]

Examples:
```Dart
print({1: 2, 3: 4}.flatMap((k, v) => [k, v])); // (1, 2, 3, 4)
```

### [`getOrDefault`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/get-or-default.html)

```Dart
V Map<K, V>.getOrDefault(K key, V defaultValue)
```

Returns the value corresponding to the given `key`, or `defaultValue` if such a `key` is not present in the `Map`.

Related: [getOrElse], [getOrNull], [getValue]

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

Related: [getOrDefault], [getOrNull], [getValue]

Examples:
```Dart
print(<String, int>{'Hello': 5}.getOrElse('World', () => 6)); // 6
print(<String, int>{'Hello': 5}.getOrElse('Hello', () => 42)); // 5
```

### [`getOrNull (Kotlin get)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/get.html)

Returns the value corresponding to the given `key`, or `null` if such a key is not present in the `Map`.

```Dart
V Map<K, V>.getOrNull(K key)
```

Related: [getOrDefault], [getOrElse], [getValue]

Examples:
```Dart
final withFoo = {'Hello': {'World': {'Foo': {'Bar': 5}}}};
final withoutFoo = {'Hello': {'World': {'Baz': {'Bar': 5}}}};

print(withFoo?.getOrNull('Hello')?.getOrNull('World')?.getOrNull('Foo')?.getOrNull('Bar')); // 5
print(withoutFoo?.getOrNull('Hello')?.getOrNull('World')?.getOrNull('Foo')?.getOrNull('Bar')); // null
```

### [`getValue`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/get-value.html)

```Dart
V Map<K, V>.getValue(K key)
```

Returns the value for the given `key` or throws a `StateError` if there is no such key in the `Map`.

Related: [getOrNull], [getOrDefault], [getOrElse]

Examples:
```Dart
print({'Hi': 2}.getValue('Hi')); // 2
print({'Hi': 2}.getValue('Hello')); // => throw StateError
```

## On `Map<K, V>`

### [`isNullOrEmpty`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/is-null-or-empty.html)

```Dart
bool get Map<K, V>.isNullOrEmpty
```

Returns `true` if this `Map` is either `null` or empty.

Related: [isEmpty], [orEmpty]

Examples:
```Dart
Map map;
print(map.isNullOrEmpty); // true
print({}.isNullOrEmpty; // true

print({0: 1}.isNullOrEmpty); // false
```

### [`mapKeys`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-keys.html)

```Dart
Map<R, V> Map<K, V>.mapKeys<R>(R Function(K) transform)
```

Returns a new `Map` with entries having the keys obtained by applying the `transform` function to each entry in this `Map` and the values of this `Map`.

- In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite the value associated with the former one.
- The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [mapValues], [map (Dart)], [mapToIterable], [mapNotNull]

Examples:
```Dart
final result = {0: 1, 2: 3}.mapKeys((k) => k + 5);

print(result); // {5: 1, 7: 3}
```

```Dart
final result = {0: 1, 2: 3}.mapKeys((i) => 0);

print(result); // {0: 3}
```

### [`mapNotNull`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-not-null.html)

```Dart
Iterable<T> Map<K, V>.mapNotNull<R>(R Function(K, V) transform)
```

Returns a lazy `Iterable` containing only the non-null results of applying the given `transform` function to each entry in the original `Map`.

Related: [mapToIterable], [map (Dart)], [mapKeys], [mapValues]

Examples:
```Dart
print({'Hi': 2, 'Yo': null}.mapNotNull((k, v) => v)); // [2]
```

### `mapToIterable`

Returns a lazy `Iterable` containing the results of applying the given `transform` function to each entry in the original `Map`.

```Dart
Iterable<T> Map<K, V>.mapToIterable<T>(T Function(K, V) transform)
```

Related: [map (Dart)], [mapKeys], [mapValues], [mapNotNull]

Examples:
```Dart
final result = {1: 2, 3: 4}.mapToIterable((k, v) => k + v);

print(result); // (3, 7)
```

### [`mapValues`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-values.html)

```Dart
Map<K, R> Map<K, V>.mapValues(R Function(V) transform)
```

Returns a new `Map` with entries having the keys of this `Map` and the values obtained by applying the `transform` function to each entry in this `Map`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [mapKeys], [map (Dart)], [mapToIterable], [mapNotNull]

Examples:
```Dart
final result = {0: 1, 2: 3}.mapValues((v) => v * 2);

print(result); // {0: 2, 2: 6}
```

```Dart
final result = {'Hello': 'World'}.mapValues((v) => '$v$v');

print(result); // {'Hello': 'WorldWorld'}
```

### [`maxBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/max-by.html)

```Dart
MapEntry<K, V> Map<K, V>.maxBy<R extends Comparable>(R Function(K, V) selector)
```

Returns the first entry yielding the largest value of the given function or null if there are no entries.

Related: [maxWith], [minBy], [minWith]

Examples:
```Dart
print({5: 20, 7: 9}.maxBy((k, v) => k)); // MapEntry(7: 9)
print({5: 20, 7: 9}.maxBy((k, v) => v)); // MapEntry(5: 20)
```

### [`maxWith`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/max-with.html)

```Dart
MapEntry<K, V> Map<K, V>.maxWith(int Function(MapEntry<K, V> e1, MapEntry<K, V> e2) compare)
```

Returns the first entry having the largest value according to the provided `compare` or `null` if there are no entries.

Related: [maxBy], [minBy], [minWith]

Examples:
```Dart
TODO
```

### [`minBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/min-by.html)

```Dart
MapEntry<K, V> Map<K, V>.minBy<R extends Comparable>(R Function(K, V) selector)
```

Returns the first entry yielding the smallest value of the given `selector` or `null` if there are no entries.

Related: [minWith], [maxWith], [maxBy]

Examples:
```Dart
print({'Hello': 2, 'Yo': 3}.minBy((k, v) => k.length)); // => MapEntry('Yo': 3)
print({'Hello': 2, 'Yo': 3}.minBy((k, v) => v)); // => MapEntry('Hello': 2)
```

### [`minWith`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/min-with.html)

```Dart
MapEntry<K, V> Map<K, V>.minWith(int Funciton(MapEntry<K, V> e1, MapEntry<K, V> e2) compare)
```

Returns the first entry having the smallest value according to the provided `compare` function or `null` if there are no entries.

Related: [minBy], [maxWith], [maxBy]

Examples:
```Dart
TODO
```

### [`none`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/none.html)

```Dart
bool Map<K, V>.none(bool Function(K, V) predicate)
```

Returns `true` if no entries match the given `predicate`.

Related: [any], [every]

Examples:
```Dart
print({'Hello': 1, 'World': 2}.none((k, v) => k == 'Foo')); // => true
print({'Hello': 1, 'World': 2}.none((k, v) => v == 42)); // => true

print({'Hello': 1, 'World': 2}.none((k, v) => k == 'Hello')); // => false
print({'Hello': 1, 'World': 2}.none((k, v) => v == 2)); // => false
```

### [`onEach`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/on-each.html)

```Dart
Map<K, V> Map<K, V>.onEach(void Function(K, V) action)
```

Performs the given `action` on each entry and returns the `Map` itself afterwards.

Related: [forEach]

Examples:
```Dart
TODO
```

### [`orEmpty`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/or-empty.html)

```Dart
Map<K, V> Map<K, V>.orEmpty()
```

Returns the `Map` if its not `null`, or an empty `Map` otherwise.

Related: [isNullOrEmpty]

Examples:
```Dart
Map map;
final orEmpty = map.orEmpty();
print(map.prEmpty); // {}

```

```Dart
Map map = {0: 1};
final orEmpty = map.orEmpty();

print(identical(map, orEmpty)); // true (same Map reference)
```

### [`plus`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/plus.html)

```Dart
Map<K, V> Map<K, V>.operator +(Map<K, V> rhs)
```

Creates a new `Map` by replacing or adding entries to this `Map` from another `Map`.

The returned `Map` preserves the entry iteration order of the original `Map`. Those entries of another `Map` that are missing in this `Map` are iterated in the end in the order of that `Map`.

Related: [addAll (Dart)]

Examples:
```Dart
print({'Hello': 1} + {'Hi': 2}); // {'Hello': 1, 'Hi': 2}
print({'Hi': 1} + {'Hi': 2}); // {'Hi': 2}
```

### [`toList`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/to-list.html)

```Dart
List<MapEntry<K, V>> Map<K, V>.toList()
```

Returns a `List` containing all key-value pairs.

Related: [mapToIterable], [toMap]

Examples:
```Dart
print({'Hello': 1, 'World': 2}.toList()); // [MapEntry('Hello': 1), MapEntry('World': 2)]
```

### [`where (Kotlin filter)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter.html)

```Dart
Map<K, V> Map<K, V>.where(bool Function(K, V) predicate)
```

Returns a new `Map` containing all key-value pairs matching the given `predicate`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [whereKeys], [whereNot], [whereValues]

Examples:
```Dart
{'Hello': 1, 'World': 2}.where((k, v) => k.contains('ello'));
// => {'Hello': 1}

{'Hello': 1, 'World': 2}.where((k, v) => v < 2);
// => {'Hello': 1}
```

### [`whereKeys (Kotlin filterKeys)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-keys.html)

```Dart
Map<K, V> Map<K, V>.whereKeys(bool Function(K) predicate)
```

Returns a `Map` containing all key-value pairs with keys matching the given `predicate`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [where], [whereNot], [whereValues]

Examples:
```Dart
{'Hello': 1, 'World': 2}.whereKeys((k) => k.contains('ello'));
// => {'Hello': 1}

{'Hello': 1, 'Jello': 2}.whereKeys((k) => k.contains('ello'));
// => {'Hello': 1, 'Jello': 2}
```

### [`whereNot (Kotlin filterNot)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-not.html)

```Dart
Map<K, V> Map<K, V>.whereNot(bool Function(K, V) predicate)
```

Returns a new `Map` containing all key-value pairs not matching the given `predicate`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [where], [whereKeys], [whereValues]

Examples:
```Dart
print({'Hello': 1, 'Hi': 2}.whereNot((k, v) => k.contains('ello'))); // {'Hi': 2}
```

### [`whereValues (Kotlin filterValues)`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-values.html)

```Dart
Map<K, V> Map<K, V>.whereValues(bool Function(V) predicate)
```

Returns a `Map` containing all key-value pairs with values matching the given `predicate`.

The returned `Map` preserves the entry iteration order of the original `Map`.

Related: [where], [whereKeys], [whereNot]

Examples:
```Dart
print({'Hello': 2, 'Hi': 1}.whereValues((v) => v > 1)); // {'Hello': 2}
```

## On `Map<K extends Comparable, V>`

[any]: #any
[asIterable]: #asIterable
[copy]: #copy
[every]: #every-kotlin-all
[flatMap]: #flatMap
[getOrDefault]: #getOrDefault
[getOrElse]: #getOrElse
[getOrNull]: #getOrNull
[getValue]: #getValue
[isNullOrEmpty]: #isNullOrEmpty
[mapKeys]: #mapKeys
[mapNotNull]: #mapNotNull
[mapToIterable]: #mapToIterable
[mapValues]: #mapValues
[maxBy]: #maxBy
[maxWith]: #maxWith
[minBy]: #minBy
[minWith]: #minWith
[none]: #none
[onEach]: #onEach
[orEmpty]: #orEmpty
[plus]: #plus
[toList]: #toList
[where]: #where
[whereKeys]: #whereKeys
[whereNot]: #whereNot
[whereValues]: #whereValues

[addAll (Dart)]: https://api.dart.dev/stable/2.3.1/dart-core/Map/addAll.html
[map (Dart)]: https://api.dart.dev/stable/2.3.1/dart-core/Map/map.html
[Map.from (Dart)]: https://api.dart.dev/stable/2.3.1/dart-core/Map/Map.from.html