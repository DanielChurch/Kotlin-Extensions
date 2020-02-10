# List Extensions

- [On List\<T\>](#on-listt)
  - [distinct](#distinct)
  - [distinctBy](#distinctBy)
  - [sortedBy](#sortedBy)
  - [sortedByDescending](#sortedByDescending)
  - [sortedWith](#sortedWith)
- [On List\<T extends Comparable\>](#on-listt-extends-comparable)
  - [sorted](#sorted)
  - [sortedDescending](#sortedDescending)

## On `List<T>`

### [`distinct`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/distinct.html)

```Dart
List<T> List<T>.distinct()
```

Returns a `List` containing only distinct elements from the given collection.

The elements in the resulting `List` are in the same order as they were in the source `List`.

Related: [distinctBy](#distinctBy)

Examples:
```Dart
final result = [0, 0, 1, 1, 2, 2].distinct();

print(result); // [0, 1, 2]
```

```Dart
final result = ['Hello', 'Hello', 'World'].distinct();

print(result); // ['Hello', 'World']
```

### [`distinctBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/distinct-by.html)

```Dart
List<T> List<T>.distinctBy(R Function(T) selector)
```

Returns a `List` containing only elements from the given `List` having distinct keys returned by the given `selector` function.

The elements in the resulting `List` are in the same order as they were in the source `List`.

Related: [distinct](#distinct)

Example:
```Dart
final result = [0, 1, 2, 3].distinctBy((i) => i % 2);

print(result); // [0, 1]
```

### [`sortedBy`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/sorted-by.html)

```Dart
List<T> List<T>.sortedBy<R>(R Function(T) selector)
```

Returns a `List` of all elements sorted according to natural sort order of the value returned by specified `selector` function.

The sort is stable. It means that equal elements preserve their order relative to each other after sorting.

Related: [sorted](#sorted), [sortedWith](#sortedWith), [sortedDescending](#sortedDescending), [sortedByDescending](#sortedByDescending)

Examples:
```Dart
final result = [1, 2, 3].sortedBy((i) => -i);

print(result); // [3, 2, 1]
```

### [`sortedByDescending`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/sorted-by-descending.html)

```Dart
List<T> List<T>.sortedByDescending<R extends Comparable>(R Function(T) selector)
```

Returns a `List` of all elements sorted descending according to natural sort order of the value returned by specified `selector` function.

The sort is stable. It means that equal elements preserve their order relative to each other after sorting.

Related: [sortedDescending](#sortedDescending), [sorted](#sorted), [sortedBy](#sortedBy), [sortedWith](#sortedWith)

Example:
```Dart
final result = ['Foo', 'Hello', 'Four'].sortedByDescending((str) => str.length);

print(result); // ['Hello', 'Four', 'Foo']
```

### [`sortedWith`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/sorted-by.html)

```Dart
List<T> List<T>.sortedWith(int Function(T, T) comparator)
```

Returns a `List` of all elements sorted according to the specified `comparator`.

The sort is stable. It means that equal elements preserve their order relative to each other after sorting.

Related: [sorted](#sorted), [sortedBy](#sortedBy), [sortedDescending](#sortedDescending), [sortedByDescending](#sortedByDescending)

Examples:
```Dart
final result = [2, 3, 1].sortedWith((i, j) => i > j ? 1 : -1);

print(result); // [1, 2, 3]
```

## On `List<T extends Comparable>`

### [`sorted`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/sorted.html)

```Dart
List<T> List<T extends Comparable>.sorted()
```

Returns a `List` of all elements sorted according to their natural sort order.

The sort is stable. It means that equal elements preserve their order relative to each other after sorting.

Related: [sortedBy](#sortedBy), [sortedWith](#sortedWith), [sortedDescending](#sortedDescending), [sortedByDescending](#sortedByDescending)

Example:
```Dart
final result = [3, 1, 2].sorted();

print(result); // [1, 2, 3]
```

### [`sortedDescending`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/sorted-descending.html)

```Dart
List<T> List<T extends Comparable>.sortedDescending()
```

Returns a `List` of all elements sorted descending according to their natural sort order.

The sort is stable. It means that equal elements preserve their order relative to each other after sorting.

Related: [sortedByDescending](#sortedByDescending), [sorted](#sorted), [sortedBy](#sortedBy), [sortedWith](#sortedWith)

Example:
```Dart
final result = [5, 2, 6].sortedDescending();

print(result); // [6, 5, 2]
```