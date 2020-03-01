import 'package:kotlin_extensions/src/util/generic_object_helper.dart';
import 'package:kotlin_extensions/typedefs.dart';

extension BinaryNegate<K, V> on BinaryPredicate<K, V> {
  BinaryPredicate<K, V> negate() {
    return (K k, V v) => !this(k, v);
  }
}

BinaryPredicate<T, K> everyBinaryPredicate<T, K>(
    Iterable<BinaryPredicate<T, K>> predicates) {
  if (predicates.any(isNull)) {
    throw ArgumentError('all predicates must not be null');
  }

  return (T e1, K e2) => predicates.every((p) => p(e1, e2));
}

extension Negate<T> on Predicate<T> {
  Predicate<T> negate() => notPredicate(this);
}

Predicate<T> notPredicate<T>(Predicate<T> predicate) {
  ArgumentError.checkNotNull(predicate);

  return (T t) => !predicate(t);
}

extension Or<T> on Predicate<T> {
  Predicate<T> or(Predicate<T> predicate) {
    ArgumentError.checkNotNull(predicate);

    return anyPredicate([this, predicate]);
  }
}

Predicate<T> anyPredicate<T>(Iterable<Predicate<T>> predicates) {
  if (predicates.any(isNull)) {
    throw ArgumentError('all predicates must not be null');
  }

  return (T element) => predicates.any((p) => p(element));
}

extension And<T> on Predicate<T> {
  Predicate<T> and(Predicate<T> predicate) {
    ArgumentError.checkNotNull('predicate');

    return everyPredicate([this, predicate]);
  }
}

Predicate<T> everyPredicate<T>(Iterable<Predicate<T>> predicates) {
  if (predicates.any(isNull)) {
    throw ArgumentError('all predicates must not be null');
  }

  return (T element) => predicates.every((p) => p(element));
}
