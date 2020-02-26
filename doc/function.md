# Function Extensions

- Definitions:
  - [Comparator]
  - [BinaryPredicate]
  - [Predicate]
- Extensions:
  - [On `Comparator<T>`](#on-comparatort)
  - [On `Predicate<T> & BinaryPredicate<K, V>`](#on-predicatet--binarypredicatek-v)
    - [and]
    - [negate]
    - [or]

## Definitions

### [`Comparator (Dart)`](https://api.flutter.dev/flutter/dart-core/Comparator.html)

```Dart
typedef Comparator<T> = int Function(T a, T b);
```

The signature of a generic comparison function.

A comparison function represents an ordering on a type of objects. A total ordering on a type means that for two values, either they are equal or one is greater than the other (and the latter must then be smaller than the former).

A Comparator function represents such a total ordering by returning

- a negative integer if a is smaller than b,
- zero if a is equal to b, and
- a positive integer if a is greater than b.

### [`BinaryPredicate (Java BiPredicate)`](https://docs.oracle.com/javase/8/docs/api/java/util/function/BiPredicate.html)

```Dart
typedef BinaryPredicate<K, V> = bool Function(K, V)
```

Represents a boolean-valued function of two arguments. This is the two-arity specialization of [Predicate](#Predicate).

### [`Predicate`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
typedef Predicate<T> = bool Function(T)
```

Represents a boolean-valued function of one argument.

## Extensions

### On `Comparator<T>`

#### [`reversed`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.comparisons/reversed.html)

```Dart
Comparator<T> get Comparator<T>.reversed
```

Returns a [Comparator] that imposes the reverse ordering of this [Comparator].

Related: 

Examples:
```Dart
final entries = [MapEntry(0, 'Foo'), MapEntry(0, 'Bar'), MapEntry(1, 'Baz')];

final result = entries.sortedWith(compareBy<MapEntry<int, String>>((entry) => entry.key).reversed);
print(result);
// [MapEntry(1: Baz), MapEntry(0: Foo), MapEntry(0: Bar)]
```

### On `Predicate<T>` & `BinaryPredicate<K, V>`

#### [`and`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
Predicate<T> Predicate<T>.and(Predicate<T> predicate)

BinaryPredicate<K, V> BinaryPredicate<K, V>.and(BinaryPredicate<K, V> predicate)
```

Returns a composed [predicate] that represents a short-circuiting logical AND of this [predicate] and another.

When evaluating the composed [predicate], if this [predicate] is false, then the other [predicate] is not evaluated.

Any exceptions thrown during evaluation of either [predicate] are relayed to the caller; if evaluation of this [predicate] throws an exception, the other [predicate] will not be evaluated.

Related: [negate], [or]

Examples:
```Dart
bool isLessThanFive(int value) => value < 5;
bool isMoreThanThree(int value) => value > 3;

final result = [2, 3, 4, 5, 6].where(isLessThanFive.and(isMoreThanThree)).toList();

print(result); // 4
```

#### [`negate`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
Predicate<T> Predicate<T>.negate()

BinaryPredicate<K, V> BinaryPredicate<K, V>.negate()
```

Returns a [predicate] that represents the logical negation of this [predicate].

Related: [and], [or]

Examples:
```Dart
bool isLessThanFive(int value) => value < 5;

print([2, 3, 4, 5, 6].where(isLessThanFive)); // (2, 3, 4)
print([2, 3, 4, 5, 6].where(isLessThanFive.negate())); // (5, 6)
```

#### [`or`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
Predicate<T> Predicate<T>.or(Predicate<T> predicate)

BinaryPredicate<K, V> BinaryPredicate<K, V>.or(BinaryPredicate<K, V> predicate)
```

Returns a composed [predicate] that represents a short-circuiting logical OR of this [predicate] and another.

When evaluating the composed predicate, if this predicate is `true`, then the other predicate is not evaluated.

Any exceptions thrown during evaluation of either [predicate] are relayed to the caller; if evaluation of this [predicate] throws an exception, the other [predicate] will not be evaluated.

Related: [and], [negate]

Examples:
```Dart
bool isMoreThanFive(int value) => value > 5;
bool isLessThanThree(int value) => value < 3;

final result = [2, 3, 4, 5, 6].where(isMoreThanFive.or(isLessThanThree)).toList();

print(result); // 2, 6
```

[and]: #and
[binaryPredicate]: #binaryPredicate-java-bipredicate
[negate]: #negate
[or]: #or
[predicate]: #predicate

[Comparator]: #Comparator-dart
[reversed]: #reversed