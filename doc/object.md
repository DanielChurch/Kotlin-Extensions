# Object Extensions

- On `T`
  - [also](#also)
  - [let](#let)

## on `T`

### [`also`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/also.html)

```Dart
T T.also(void Function(T) block)
```

Calls the specified function `block` with `this` value as its argument and returns `this` value. 

Related: [let](#let)

Examples:
```Dart
final result = 'Hello'.also(print) + ' World'; // 'Hello'

print(result); // 'Hello World'
```

```Dart
Map<K, V> toMap<K, V>(Iterable<Map<K, V>> mapEntries) {
  return <K, V>{}.also((output) => mapEntries.forEach(output.addAll));
}

print(toMap([{1: 2}, {3: 4}])); // {1: 2, 3: 4}
```

### [`let`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/let.html)

```Dart
R T.let<R>(R Function(T) block)
```

Calls the specified function block with `this` value as its argument and returns its result.

Related: [also](#also)

Example:
```Dart
String reverse(String text) {
  return text?.let((text) {
    final characters = text.split('');
    final backwards = characters.reversed;

    return backwards.join('');
  }) ?? '';
}

print(reverse('Hello')); // 'olleH'
```

### [`to`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/to.html)

```Dart
MapEntry<T, V> T.to(V that)
```

Creates a `MapEntry<T, V>` from `this` to `that`.

Examples:
```Dart
print('Hello'.to('World')); // MapEntry(Hello, World)
```