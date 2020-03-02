# Function Extensions

- [On `bool Function(T)` & `bool Function(K, V)`](#on-bool-functiont)
  - [and]
  - [negate]
  - [or]

## On `bool Function(T)`

### [`and`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
bool Function(T) (bool Function(T)).and(bool Function(T) predicate)

bool Function(K, V) (bool Function(K, V)).and(bool Function(K, V) predicate)
```

Returns a composed `predicate` that represents a short-circuiting logical AND of this `predicate` and another.

When evaluating the composed `predicate`, if this `predicate` is false, then the other `predicate` is not evaluated.

Any exceptions thrown during evaluation of either `predicate` are relayed to the caller; if evaluation of this `predicate` throws an exception, the other `predicate` will not be evaluated.

Related: [negate], [or]

Examples:
```Dart
bool isLessThanFive(int value) => value < 5;
bool isMoreThanThree(int value) => value > 3;

final result = [2, 3, 4, 5, 6].where(isLessThanFive.and(isMoreThanThree)).toList();

print(result); // 4
```

### [`negate`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
bool Function(T) (bool Function(T)).negate()

bool Function(K, V) (bool Function(K, V)).negate()
```

Returns a `predicate` that represents the logical negation of this `predicate`.

Related: [and], [or]

Examples:
```Dart
bool isLessThanFive(int value) => value < 5;

print([2, 3, 4, 5, 6].where(isLessThanFive)); // (2, 3, 4)
print([2, 3, 4, 5, 6].where(isLessThanFive.negate())); // (5, 6)
```

### [`or`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html)

```Dart
bool Function(T) (bool Function(T)).or(bool Function(T) predicate)

bool Function(K, V) (bool Function(K, V)).or(bool Function(K, V) predicate)
```

Returns a composed `predicate` that represents a short-circuiting logical OR of this `predicate` and another.

When evaluating the composed predicate, if this predicate is `true`, then the other predicate is not evaluated.

Any exceptions thrown during evaluation of either `predicate` are relayed to the caller; if evaluation of this `predicate` throws an exception, the other `predicate` will not be evaluated.

Related: [and], [negate]

Examples:
```Dart
bool isMoreThanFive(int value) => value > 5;
bool isLessThanThree(int value) => value < 3;

final result = [2, 3, 4, 5, 6].where(isMoreThanFive.or(isLessThanThree)).toList();

print(result); // 2, 6
```

[and]: #and
[negate]: #negate
[or]: #or