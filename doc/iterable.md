# Iterable Extensions

- [On Iterable\<T\>](#on-iterablet)
  - [associate](#associate)
  - [associateBy](#associateBy)
  - [associateWith](#associateWith)
  - [containsAll](#containsAll)
  - [firstOrNull](#firstOrNull)
  - [flatMap](#flatMap)
  - [forEachIndexed](#forEachIndexed)
  - [groupBy](#groupBy)
  - [isNullOrEmpty](#isNullOrEmpty)
  - [lastOrNull](#lastOrNull)
  - [mapIndexed](#mapIndexed)
  - [mapIndexedNotNull](#mapIndexedNotNull)
  - [mapNotNull](#mapNotNull)
  - [maxBy](#maxBy)
  - [maxWith](#maxWith)
  - [minBy](#minBy)
  - [minWith](#minWith)
  - [partition](#partition)
  - [reduceIndexed](#reduceIndexed)
  - [reduceIndexedOrNull](#reduceIndexedOrNull-not-from-kotlin)
  - [reduceOrNull](#reduceOrNull-not-from-kotlin)
  - [whereIndexed](#whereIndexed-kotlin-filterIndexed)
  - [whereIsNotNull](#whereIsNotNull-not-from-kotlin)
  - [whereNot (Kotlin filterNot)](#whereNot-kotlin-filterNot)
  - [whereNotNull](#whereNotNull-kotlin-filterNotNull)
- [On Iterable\<Iterable\<T\>\>](#on-iterableiterablet)
  - [flatten](#flatten)
- [On Iterable\<Map\<K, V\>\>](#on-iterablemapk-v)
  - [toMap](#toMap)
- [On Iterable\<num\>](#on-iterablenum-&-iterableint)
  - [average](#average)
  - [sum](#sum)
- [On Iterable\<T extends Comparable\>](#on-iterablet-extends-comparable)
  - [max](#max)
  - [min](#min)

## on `Iterable<T>`

### [`associate`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/associate.html)

```Dart
Map<K, V> Iterable<T>.associate<K, V>(Map<K, V> Function(T) transform))
```

Returns a `Map` containing key-value pairs provided by the `transform` function applied to elements of the given `Iterable`.

- The `transform` function can return multiple key-value pairs and all will be added to the resulting `Map`.
- If any of two pairs would have the same key the last one gets added to the `Map`.
- The returned `Map` preserves the entry iteration order of the original `Iterable`.

Related: [associateBy](#associateBy), [associateWith](#associateWith)

Examples:
```Dart
final result = [0, 1, 2, 3].associate((i) => {i: '$i'});

print(result); // {0: '0', 1: '1', 2: '2', 3: '3'}
```

```Dart
final result = [0, 1].associate((i) => {i: '$i', -i: '$i'});

print(result); // {0: '0', 1: '1', -1: '1'}
```

### [`associateBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/associate-by.html)

```Dart
Map<K, V> Iterable<T>.associateBy<K, V>({@required K Function(T) key, @required V Function(T) value})
```

Returns a `Map` containing the values provided by `value` and indexed by the `key` functions applied to elements of the given `Iterable`.

- If any two elements would have the same key returned by `key` the last one gets added to the map.
- The returned `Map` preserves the entry iteration order of the original `Iterable`.

Related: [associate](#associate), [associateWith](#associateWith)

Example:
```Dart
final result = [0, 1, 2, 3].associateBy(key: (i) => i * 5, value: (i) => -i);

print(result); // {0: 0, 5: -1, 10: -2, 15: -3}
```

### [`associateWith`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/associate-with.html)

```Dart
Map<T, V> Iterable<T>.associateWith<K, V>(V Function(T) valueSelector)
```

Returns a `Map` where keys are elements from the given collection and values are produced by the `valueSelector` function applied to each element.

- If any two elements are equal, the last one gets added to the `Map`.
- The returned `Map` preserves the entry iteration order of the original collection.

Related: [associate](#associate), [associateBy](#associateBy)

Example:
```Dart
final result = ['a', 'abc', 'ab', 'def', 'abcd'].associateWith((s) => s.length);

print(result); // {'a': 1, 'abc': 3, 'ab': 2, 'def': 3, 'abcd': 4}
```

### [`containsAll`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/contains-all.html)

```Dart
bool Iterable<T>.containsAll(Iterable<T> elements)
```

Checks if all elements in the specified collection are contained in `this` collection.

Examples:
```Dart
final result = [0, 1, 2].containsAll([0, 1]);

print(result); // true
```

```Dart
final result = [0, 1, 3].containsAll([0, 1, 4]);

print(result); // false
```

### [`firstOrNull`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/first-or-null.html)

```Dart
T get Iterable<T>.firstOrNull
```

Returns the first element, or `null` if the collection is empty or `null`.

Related: [last (Dart)], [lastOrNull](#lastOrNull), [first (Dart)]

Examples:
```Dart
print(null.firstOrNull); // null
print([].firstOrNull); // null
print([0, 1, 2].firstOrNull); // 0
```

### [`flatMap`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/flat-map.html)

```Dart
Iterable<R> Iterable<T>.flatMap<R>(Iterable<R> Function(T) transform)
```

Returns a lazy `Iterable` of all elements yielded from the results of transform function being invoked on each entry of the original `Iterable`.

Related: [map (Dart)], [mapIndexed](#mapIndexed), [mapIndexedNotNull](#mapIndexedNotNull), [mapNotNull](#mapNotNull)

Example:
```Dart
[0, 1, 2].flatMap((i) => [i, i + 5]); // => (0, 5, 1, 6, 2, 7)
```

### [`forEachIndexed`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/for-each-indexed.html)

```Dart
void Iterable<T>.forEachIndexed(void Function(int, T) indexedAction)
```

Performs the given [action] on each element, providing sequential index (starting at 0) with the element.

Related: [forEach (Dart)]

Example:
```Dart
['Hello', 'World'].forEachIndexed((int index, String text) {
  print('$text $index');
});

// Hello 0
// World 1
```

### [`groupBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/group-by.html)

```Dart
Map<R, T> Iterable<T>.groupBy<R>(R Function(T) selector)
```

Groups elements of the original `Iterable` by the key returned by the given keySelector function applied to each element and returns a `Map` where each group key is associated with a list of corresponding elements.

The returned `Map` preserves the entry iteration order of the keys produced from the original `Iterable`.

Example:
```Dart
final result = ['a', 'abc', 'ab', 'def', 'abcd'].groupBy((i) => i.length);

print(result); // {1: [a], 3: [abc, def], 2: [ab], 4: [abcd]}
```

### [`isNullOrEmpty`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/is-null-or-empty.html)

```Dart
bool get Iterable<T>.isNullOrEmpty
```

Returns `true` if this Iterable is either `null` or empty.

Examples:
```Dart
print(null.isNullOrEmpty); // true
print([].isNullOrEmpty); // true
print([0, 1].isNullOrEmpty); // false
```

### [`lastOrNull`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/last-or-null.html)

```Dart
T get Iterable<T>.lastOrNull
```

Returns the last element, or `null` if the collection is empty or `null`.

Related: [last (Dart)], [first (Dart)], [firstOrNull](#firstOrNull)

Examples:
```Dart
print(null.lastOrNull);// null
print([].lastOrNull); // null
print([0, 1, 2].lastOrNull); // 2
```

### [`mapIndexed`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-indexed.html)

```Dart
Iterable<R> Iterable<T>.mapIndexed<R>(R Function(int, T) indexedTransform)
```

Returns a lazy Iterable containing the results of applying the given `transform` function to each element and its index in the original collection.

Related: [map (Dart)], [flatMap](#flatMap), [mapIndexedNotNull](#mapIndexedNotNull), [mapNotNull](#mapNotNull)

Example:
```Dart
final result = ['Hello', 'World'].mapIndexed((int index, String text) {
  return '$text $index';
});

print(result); // ('Hello 0', 'World 1')
```

### [`mapIndexedNotNull`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-indexed-not-null.html)

```Dart
Iterable<R> Iterable<T>.mapIndexedNotNull<R>(R Function(int, T) indexedTransform)
```

Returns a lazy `Iterable` containing only the non-null results of applying the given `transform` function to each element and its index in the original collection.

Does not `null` check the elements before the `indexedTransform` is applied.

Related: [map (Dart)], [flatMap](#flatMap), [mapIndexed](#mapIndexed), [mapNotNull](#mapNotNull)

Example:
```Dart
final result = ['Hello', 'Foo', 'World'].mapIndexedNotNull((int index, String text) {
  if (text == 'Foo') return null;

  return '$text $index';
}); 

print(result); // ('Hello 0', 'World 2')
```

### [`mapNotNull`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/map-not-null.html)

```Dart
Iterable<R> Iterable<T>.mapNotNull<R>(R Function(T) transform)
```

Returns a lazy `Iterable` containing only the non-null results of applying the given `transform` function to each element in the original collection.

Does not null check the elements before the `transform` is applied.

Related: [map (Dart)], [flatMap](#flatMap), [mapIndexed](#mapIndexed), [mapIndexedNotNull](#mapIndexedNotNull)

Example:
```Dart
final result = [0, 1, 2, 3].mapNotNull((i) {
  if (i % 2 == 0) return null;

  return i;
});

print(result); // (1, 3)
```

### [`maxBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/max-by.html)

```Dart
T Iterable<T>.maxBy<R extends Comparable>(R Function(T) selector)
```

Returns the first element yielding the largest value of the given `selector` or `null` if there are no elements.

Related: [max](#max), [maxWith](#maxWith), [min](#min), [minBy](#minBy), [minWith](#minWith)

Example:
```Dart
final result = ['Hello World', 'Foo', 'Bar', 'Baz'].maxBy((text) => text.length);

print(result); // 'Hello World'
```

### [`maxWith`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/max-with.html)

```Dart
T Iterable<T>.maxWith(int Function(T, T) comparator)
```

Returns the first element having the largest value according to the provided `comparator` or null if there are no elements.

Related: [max](#max), [maxBy](#maxBy), [min](#min), [minBy](#minBy), [minWith](#minWith)

Example:
```Dart
final result = [0, 1, 2].maxWith((i, j) => i > j ? 1 : -1);

print(result); // 2
```

```Dart
final result = [0, 1, 2].maxWith((i, j) => i < j ? 1 : -1);

print(result); // 0
```

### [`minBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/max-by.html)

```Dart
T Iterable<T>.minBy<R extends Comparable>(R Function(T) selector)
```

Returns the first element yielding the smallest value of the given `selector` function or `null` if there are no elements.

Related: [min](#min), [minWith](#minWith), [max](#max), [maxBy](#maxBy), [maxWith](#maxWith)

Examples:
```Dart
final data = {'World': 1, 'Hello': 0};
data.keys.minBy((i) => data[i]); // => 'Hello'
```

```Dart
final shortest = ['Hello', 'World', 'Foo', 'Bar'].minBy((str) => str.length);

print(shortest); // 'Foo'
```

### [`minWith`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/min-with.html)


```Dart
T Iterable<T>.minWith(int Function(T, T) comparator)
```

Returns the first element having the smallest value according to the provided `comparator` or null if there are no elements.

Related: [min](#min), [minBy](#minBy), [max](#max), [maxBy](#maxBy), [maxWith](#maxWith)

Example:
```Dart
final result = [0, 1, 2].minWith((i, j) => i > j ? 1 : -1);

print(result); // 0
```

```Dart
final result = [0, 1, 2].minWith((i, j) => i < j ? 1 : -1);

print(result); // 2
```

### [`partition`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/partition.html)

```Dart
Pair<Iterable<T>, Iterable<T>> Iterable<T>.partition(bool Function(T) predicate)
```

Splits the original `Iterable` into a `Pair` of `Iterable`s, where first `Iterable` contains elements for which `predicate` yielded `true`, while second `Iterable` contains elements for which predicate yielded `false`.

Example:
```Dart
final result = [0, 1, 2, 3].partition((i) => i > 1);

print(result); // Pair((0, 1), (2, 3))
```

```Dart
final result = ['Hello', 'World', 'Foo', 'Bar'].partition((s) => s.contains('o'));

print(result); // Pair(('Hello', 'World', 'Foo'), ('Bar'))
```

### [`reduceIndexed`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/reduce-indexed.html)

```Dart
T Iterable<T>.reduceIndexed(T Function(int, T, T) indexedCombine)
```

Accumulates value starting with the first element and applying operation from left to right to current accumulator value and each element with its index in the original `Iterable`.

- If the `Iterable` is empty, throws `Bad state: No element`.
- If the `Iterable` has one element, that element is returned.
- The index starts at 1.

Related: [reduceIndexedOrNull](#reduceIndexedOrNull-not-from-kotlin), [reduce (Dart)], [reduceOrNull](#reduceOrNull-not-from-kotlin)

Example:
```Dart
[].reduceIndexed((i, j, k) => j); // => Bad state: No element
print([5].reduceIndexed((i, j, k) => j)); // 5
```

```Dart
final result = [0, 1].reduceIndexed((index, first, second) {
  print('($index $first $second)');

  return index + first + second;
});

// (1 + 0 + 1)

print(result); // 2
```

```Dart
final result = [0, 1, 2].reduceIndexed((index, first, second) {
  print('($index $first $second)');

  return index + first + second;
});

// (1 + 0 + 1)
// (2 + 2 + 2)

print(result); // 6
```

### `reduceIndexedOrNull` (not from Kotlin)

```Dart
T Iterable<T>.reduceIndexedOrNull(T Function(int, T, T) combinator)
```

Accumulates value starting with the first element and applying operation from left to right to current accumulator value and each element with its index in the original `Iterable`.

- If the `Iterable` is empty, throws `Bad state: No element`.
- If the `Iterable` has one element, that element is returned.
- The index starts at 1.

Related: [reduceIndexed](#reduceIndexed), [reduce (Dart)], [reduceOrNull](#reduceOrNull-not-from-kotlin)

Example:
```Dart
print([].reduceIndexedOrNull((i, j, k) => j)); // => null
print([5].reduceIndexedOrNull((i, j, k) => j)); // => 5
```

```Dart
final result = [0, 1].reduceIndexedOrNull((index, first, second) {
  print('($index + $first + $second)');

  return index + first + second;
});

// (1 + 0 + 1)

print(result); // 2
```

```Dart
final result = [0, 1, 2].reduceIndexedOrNull((index, first, second) {
  print('($index + $first + $second)');

  return index + first + second;
});

// (1 + 0 + 1)
// (2 + 2 + 2)

print(result); // 6
```

### `reduceOrNull` (not from Kotlin)

```Dart
T Iterable<T>.reduceOrNull(T Function(T, T) combinator)
```

Accumulates value starting with the first element and applying operation from left to right to current accumulator value and each element.

- If the `Iterable` is empty, returns `null`.
- If the `Iterable` has one element, that element is returned.

Related: [reduce (Dart)], [reduceIndexed](#reduceIndexed), [reduceIndexedOrNull](#reduceIndexedOrNull-not-from-kotlin)

Example:
```Dart
print([].reduceOrNull((i, j) => j)); // => null
print([5].reduceOrNull((i, j) => j)); // => 5
```

```Dart
final result = [0, 1, 2].reduceOrNull((first, second) {
  print('($first + $second)');

  return first + second;
});

// (0 + 1)
// (1 + 2)

print(result); // 3
```

### [`whereIndexed` (Kotlin `filterIndexed`)](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-indexed.html)

```Dart
Iterable<T> Iterable<T>.whereIndexed(bool Function(int, T) predicate)
```

Returns a lazy `Iterable` containing only elements matching the given `predicate`.

Related: [where (Dart)], [whereIsNotNull](#whereIsNotNull), [whereNotNull](#whereNotNull), [whereNot](#whereNot)

Examples:
```Dart
final result = ['Hello', 'World', 'Foo'].whereIndexed((int index, String text) {
  return index == 0 || text == 'World';
});

print(result); // ('Hello', 'World')
```

```Dart
class Data {
  String id;

  @override
  String toString() => 'Data(id = $id)';
}

final result = [Data()..id = 'test', Data()].whereIsNotNull((data) => data.id);

print(result); // (Data(id = 'test'))
```

### `whereIsNotNull` (not from Kotlin)

```Dart
Iterable<T> Iterable<T>.whereIsNotNull<R>(R Function(T) transform)
```

Returns a lazy `Iterable` containing all elements of the original `Iterable`, where the result of `transform` applied on the elements is not `null`.

Does not `null` check the element before `transform` is applied.

Related: [where (Dart)], [whereIndexed](#whereIndexed-kotlin-filterIndexed), [whereNotNull](#whereNotNull), [whereNot](#whereNot)

Example:
```Dart
final result = [0, 1].whereIsNotNull((i) => i == 0 ? null : i);

print(result); // (1)
```

### [`whereNot` (Kotlin `filterNot`)](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-not.html)

```Dart
Iterable<T> Iterable<T>.whereNot(bool Function(T) predicate)
```

Returns a lazy `Iterable` containing all elements not matching the given `predicate`.

Related: [where (Dart)], [whereIndexed](#whereIndexed-kotlin-filterIndexed), [whereIsNotNull](#whereIsNotNull), [whereNotNull](#whereNotNull)

Examples:
```Dart
final result = [0, 1, 2, 3].whereNot((i) => i == 2);

print(result); // (0, 1, 3)
```

```Dart
final result = ['Hello', 'Foo', 'World'].whereNot((i) => i == 'Foo');

print(result); // ('Hello', 'World')
```

### [`whereNotNull` (Kotlin `filterNotNull`)](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-not-null.html)

```Dart
Iterable<T> Iterable<T>.whereNotNull()
```

Returns a lazy `Iterable` containing all elements that are not `null`.

Related: [where (Dart)], [whereIndexed](#whereIndexed-kotlin-filterIndexed), [whereIsNotNull](#whereIsNotNull), [whereNot](#whereNot)

Example:
```Dart
print([0, null, 1].whereNotNull()); // (0, 1)
```

## On `Iterable<Iterable<T>>`

### [`flatten`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/flatten.html)

```Dart
Iterable<T> Iterable<Iterable<T>>.flatten()
```

Returns a flat `Iterable` of all elements from all `Iterable`s in the given collection.

Related: [flatMap](#flatMap)

Examples:
```Dart
final flattened = [[0, 1], [2, 3]].flatten();

print(flattened); // [0, 1, 2, 3]
```

```Dart
final flattened = [[[0, 1], [2, 3]], [4, 5]].flatten();

print(flattened); // [[0, 1], [2, 3], 4, 5]
```

```Dart
final flattened = [[[0, 1], [2, 3]].flatten(), [4, 5]].flatten();

print(flattened); // [0, 1, 2, 3, 4, 5]
```

## On `Iterable<Map<K, V>>`

### [`toMap`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/to-map.html)

```Dart
Map<K, V> Iterable<Map<K, V>>.toMap()
```

Returns a new `Map` containing all key-value pairs from the given collection.

The returned `Map` preserves the entry iteration order of the original collection.
If any of two pairs would have the same key the last one gets added to the `Map`.

Examples:
```Dart
final map = [{'Hello': 'World'}, {'Foo': 'Bar'}].toMap();

print(map); // {'Hello': 'World', 'Foo': 'Bar'}
```

```Dart
final map = [0, 1, 2, 3].map((i) => {i: i + 1}).toMap();

print(map); // {0: 1, 1: 2, 2: 3, 3: 4}
```

```Dart
final map = [{'Hello': 'Foo'}, {'Hello': 'World'}].toMap();

print(map); // {'Hello': 'World'}
```

## On `Iterable<num>` & `Iterable<int>`

### [`sum`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/sum.html)

```Dart
num get Iterable<num>.sum
int get Iterable<int>.sum
```

Returns the sum of all elements in the collection.

Returns 0 when the collection is empty.

Examples:
```Dart
print(<int>[].sum); // 0
```

```Dart
print([2, 2, 5].sum); // 9
```

```Dart
print([10.5, .5].sum); // 11
```

### [`average`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/average.html)

```Dart
num get Iterable<num>.average
num get Iterable<int>.average
```

Returns an average value of elements in the collection.

Returns `NaN` when the collection is empty.

Examples:
```Dart
print([].average); // NaN
```

```Dart
print([1, 2, 3].average); // 2
```

## On `Iterable<T extends Comparable>`

### [`max`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/max.html)

```Dart
T get Iterable<T extends Comparable>.max
```

Returns the largest element or `null` if there are no elements.

Related: [maxBy](#maxBy), [maxWith](#maxWith), [min](#min), [minBy](#minBy), [minWith](#minWith)

Examples:
```Dart
print([8, 10, 2].max); // 10
```

```Dart
print(<int>[].max); // null
```

### [`min`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/min.html)

```Dart
T get Iterable<T extends Comparable>.min
```

Returns the smallest element or `null` if there are no elements.

Related: [minBy](#minBy), [minWith](#minWith), [max](#max), [maxBy](#maxBy), [maxWith](#maxWith)

Examples:
```Dart
print([8, 10, 2].min); // 2
```

```Dart
print(<int>[].min); // null
```

[reduce (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/reduce.html
[forEach (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/forEach.html
[map (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/map.html
[where (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/where.html
[last (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/last.html
[first (Dart)]: https://api.flutter.dev/flutter/dart-core/Iterable/first.html